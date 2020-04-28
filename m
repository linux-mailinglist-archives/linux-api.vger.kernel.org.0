Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D541BBB08
	for <lists+linux-api@lfdr.de>; Tue, 28 Apr 2020 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727788AbgD1KSb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Apr 2020 06:18:31 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36996 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgD1KS3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Apr 2020 06:18:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id z6so2227596wml.2;
        Tue, 28 Apr 2020 03:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qgiXWJlcms+tTPupotLSqm+FPBcp40FxYQcAy22/92c=;
        b=PKTnblne8eHvVRK4xGZsUWjyNuGMQORdyZ3FtxDiedUhKUUxULxC14h0/tppQWvgNv
         M/+Tpe+Fl6is7tRxTDjCxNqJhw2DfT3vQGZ0Q3hnGpAu9EeO6+yDlOlW452sc0WlEqHc
         r3HqkDWSRv8IMkMKRT0f8uNC03RTlcW7SPVr8RZhgB/j52rGgxQSY/ojhfXfhw6Ky9gl
         p+rhYJxLOv7jGfDZz2G+wpDEPADZrIL7v2eXwNxXQqYIOAPxhpRXmtXURqfrffkdjO4O
         I1OYYTh243ly9rREEcoxVcCe3Cj59lQSmPYIpthnGURadQez0MRkR5dxANVIppmoM+8r
         KNUg==
X-Gm-Message-State: AGi0PuZed40n9FdNFJKC7JDGYTORC/pIiN/9jFpoqeUKWWDVqd/v+xtE
        j7JbXQRPctXkiHP2DrSEjF8=
X-Google-Smtp-Source: APiQypKaVlZdmQXw/ZzzWZ6j47uEjNYIq3GhJxratCznfb6J/PNvpcSIoVMkLjM62NOPUvw5xo+LzQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr3944326wmg.110.1588069106197;
        Tue, 28 Apr 2020 03:18:26 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id h3sm24489313wrm.73.2020.04.28.03.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 03:18:25 -0700 (PDT)
Date:   Tue, 28 Apr 2020 12:18:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3 1/5] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <20200428101824.GM28637@dhcp22.suse.cz>
References: <20200427180433.7029-1-vbabka@suse.cz>
 <20200427180433.7029-2-vbabka@suse.cz>
 <20200427113331.f0c1e8e7cee98644260448d3@linux-foundation.org>
 <d7d01e9e-6b6d-47ce-c750-cd7296e30613@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7d01e9e-6b6d-47ce-c750-cd7296e30613@suse.cz>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 28-04-20 10:09:37, Vlastimil Babka wrote:
> On 4/27/20 8:33 PM, Andrew Morton wrote:
> > On Mon, 27 Apr 2020 20:04:29 +0200 Vlastimil Babka <vbabka@suse.cz> wrote:
> > 
> > > ...
> > > +	sysctl.*=	[KNL]
> > > +			Set a sysctl parameter, right before loading the init
> > > +			process, as if the value was written to the respective
> > > +			/proc/sys/... file. Both '.' and '/' are recognized as
> > > +			separators. Unrecognized parameters and invalid values
> > > +			are reported in the kernel log. Sysctls registered
> > > +			later by a loaded module cannot be set this way.
> > > +			Example: sysctl.vm.swappiness=40
> > 
> > Why support "."?  I think only supporting "/" is perfectly adequate and
> > simplifies documentation.  It aligns the command-line syntax with the
> > rest of the sysctl documentation.  I'm not seeing the need to provide
> > two ways of doing the same thing?
> 
> AFAIK the "." is traditional, and "/" is a newer artefact of moving from the
> binary syscall form to procfs based form. So by "command-line syntax" you
> mean echo and cat, not sysctl tool? Because "man sysctl" says:
> 
> variable
> 	The name of a key to read from.  An example is kernel.ostype.  The '/'
> separator is also accepted in place of a '.'.
> 
> So I'm not strongly against supporting only / but I expect most people are
> used to the . and it will take them two attempts to pass the sysctl boot
> parameter correctly if they don't use it regularly - first trying . form,
> wonder why it doesn't work, then read the doc and realize it's not
> supported?

Yes, I do agree. I have only recently learned that sysctl supports / as
well. Most people are simply used to . notation. The copy of the arch
and . -> / substitution is a trivial operation and I do not think it is
a real reason to introduce unnecessarily harder to use interface.
-- 
Michal Hocko
SUSE Labs
