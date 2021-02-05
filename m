Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62BB3310F1D
	for <lists+linux-api@lfdr.de>; Fri,  5 Feb 2021 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233382AbhBEQIZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 5 Feb 2021 11:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229669AbhBEQGK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 5 Feb 2021 11:06:10 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89B1564DD4;
        Fri,  5 Feb 2021 17:47:50 +0000 (UTC)
Date:   Fri, 5 Feb 2021 12:47:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH] printk: Userspace format enumeration support
Message-ID: <20210205124748.4af2d406@gandalf.local.home>
In-Reply-To: <YB11jybvFCb95S9e@alley>
References: <YBwU0G+P0vb9wTwm@chrisdown.name>
        <YB11jybvFCb95S9e@alley>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, 5 Feb 2021 17:42:55 +0100
Petr Mladek <pmladek@suse.com> wrote:

> Hi,
> 
> I would like to hear opinion from a bigger audience. It is an
> userspace interface that we might need to maintain forewer.
> Adding few more people in to CC:
> 
> Steven Rostedt <rostedt@goodmis.org>: printk co-maintainer

Thanks for Cc'ing me.

> Alexey Dobriyan <adobriyan@gmail.com>: fs/proc maintainer
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>: sysfs maintainer
> Jason Baron <jbaron@akamai.com>: dynamic_debug maintainer
> Kees Cook <keescook@chromium.org>: security POV
> linux-api@vger.kernel.org: Linux API mailing list
> 
> Of course, we should also ask if this is the right approach
> for the think that you want to achieve.
> 
> The motivation for this patch is that the strings printed by kernels
> are not reliable and you want a simple way to compare differences
> bethween versions. Do I get it right?
> 
> See more comments below.
> 
> 


> Also this is yet another style how the format is displayed. We already have
> 
> 	+ console/syslog: formated by record_print_text()
> 	+ /dev/kmsg: formatted by info_print_ext_header(),  msg_print_ext_body().
> 	+ /sys/kernel/debug/dynamic_debug/control


> 	+ /sys/kernel/debug/tracing/printk_formats
> 
> We should get some inspiration from the existing interfaces.

Interesting, because when I was looking at the original patch (looked at
the lore link before reading your reply), I thought to myself "this looks
exactly like what I did for trace_printk formats", which the above file is
where it is shown. I'm curious if this work was inspired by that?



> > diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> > index 34b7e0d2346c..0ca6e28e05d6 100644
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -309,6 +309,17 @@
> >  #define ACPI_PROBE_TABLE(name)
> >  #endif
> >  
> > +#ifdef CONFIG_PRINTK_ENUMERATION
> > +#define PRINTK_FMTS							\
> > +	.printk_fmts : AT(ADDR(.printk_fmts) - LOAD_OFFSET) {		\
> > +		__start_printk_fmts = .;				\
> > +		*(.printk_fmts)						\
> > +		__stop_printk_fmts = .;					\
> > +	}
> > +#else
> > +#define PRINTK_FMTS
> > +#endif  
> 
> It should be defined after #define TRACEDATA to follow the existing
> style.
> 
> But honestly I am not much familiar with the sections definitions.
> I am curious why TRACE_PRINTKS() and __dyndbg are defined
> a bit different way.
> 

I'm not sure what difference you mean.

> > +static int proc_pf_show(struct seq_file *s, void *v)
> > +{
> > +	const struct printk_fmt_sec *ps = NULL;
> > +	const char **fptr = NULL;
> > +
> > +	mutex_lock(&printk_fmts_mutex);
> > +
> > +	list_for_each_entry(ps, &printk_fmts_list, list) {
> > +		const char *mod_name = ps_get_module_name(ps);
> > +
> > +		for (fptr = ps->start; fptr < ps->end; fptr++) {
> > +			seq_puts(s, mod_name);
> > +			seq_putc(s, ',');
> > +			seq_puts(s, *fptr);
> > +			seq_putc(s, '\0');
> > +		}  
> 
> You probably should get inspiration from t_show() in trace_printk.c.
> It handles newlines, ...
> 
> Or by ddebug_proc_show(). It uses seq_escape().
> 
> Anyway, there is something wrong at the moment. The output looks fine
> with cat. But "less" says that it is a binary format and the output
> is a bit messy:

Hmm, that's usually the case when lseek gets messed up. Not sure how that
happened.

> 
> $> less /proc/printk_formats   
> "/proc/printk_formats" may be a binary file.  See it anyway? 
> vmlinux,^A3Warning: unable to open an initial console.
> ^@vmlinux,^A3Failed to execute %s (error %d)
> ^@vmlinux,^A6Kernel memory protection disabled.
> ^@vmlinux,^A3Starting init: %s exists but couldn't execute it (error %d)
> 
> 
> That is for now. I still have to think about it. And I am also curious
> about what others thing about this idea.
> 

I'm not against the idea. I don't think it belongs in /proc. Perhaps
debugfs is a better place to put it.

-- Steve
