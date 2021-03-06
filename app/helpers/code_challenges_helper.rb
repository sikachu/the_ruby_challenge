module CodeChallengesHelper
  def render_code_snippet(code_sample)
    code_sample_lines = code_sample.split(/\n/)

    if code_sample_lines.size > 10
      truncated_code_sample = (code_sample_lines.first(9) + ["# ..."]).join("\n")
    else
      truncated_code_sample = code_sample
    end

    render_code_sample(truncated_code_sample)
  end

  def render_code_sample(code_sample)
    CodeRay.scan(code_sample, :ruby).div(css: :class).html_safe
  end

  def checkmark_if(condition)
    if condition
      "&#10003;".html_safe
    end
  end

  def runtime(usec)
    if usec
      "%.03f ms" % (usec / 1000.0)
    end
  end
end
