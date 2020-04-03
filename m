Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92CDC19E1AC
	for <lists+linux-api@lfdr.de>; Sat,  4 Apr 2020 01:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgDCX5z (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 3 Apr 2020 19:57:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42066 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDCX5z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 3 Apr 2020 19:57:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id g6so2415292pgs.9
        for <linux-api@vger.kernel.org>; Fri, 03 Apr 2020 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UPVAT2L8fukLZnuc3+5vueRjOJrPf8klG/eXO9o8hxw=;
        b=QEtE6aolufF+32AwcMQjO4gb9bIL99mZp48e8c01C1msnBx3pQym12/IQ+LgE/ux3F
         CVcMLTu06BWrANlH++15E5ZtzRpx/dHJ2ATqpFT+gejRbnrdSa0e/lZedv2fq2fc1xWF
         p6HKmiz+g/AW2y250AEiEIm0nKlW0sXeqbLuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UPVAT2L8fukLZnuc3+5vueRjOJrPf8klG/eXO9o8hxw=;
        b=uNYWMtUeqls1Cuol5flPX6RBO8Nenr5uitVU4kGhk8tXiYUTcsPhIFzmcbp8t+YKyl
         shvvaLJ0OMpKWdrCxLrglg/PEDBCHZzjQ9OzX/JhHw3DBfgrSyK4f5428jyOsvFqYcCZ
         y4h0azfQiD3jOS4ITLFzPl1QsXxk6jbwDnklX8/zcHeml7gdUI15GOWe+Fczccshu3mL
         HxtJu/qLl9R2Hs6j15Vt3Ef2b9Vxzxbz2bO1/pgh/t+xHRtlidOIwM+T0E4oKDSG12wP
         h65wvmoCBy/qIBFF3iDiW1ZSa72ZTCq66cVq3Yaf8cb3icn2f6jqBOrnbPnDwZ8dU1Nw
         xKAQ==
X-Gm-Message-State: AGi0PuZOBIwwab5x35lcoyG0h6DLPWtHVngmhcGT2wjOjczjbXqjzHri
        JVqEM3Izm+qRAnDR3D0WO4Jdag==
X-Google-Smtp-Source: APiQypLaamdlVDp6BoXHF0qVh4WK6KwXWUcTKrfXP1OuIDxH+nfTux9xP69euEIaJLF5YWHtAAFDRg==
X-Received: by 2002:a63:ce4a:: with SMTP id r10mr10771972pgi.225.1585958273804;
        Fri, 03 Apr 2020 16:57:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y131sm6528000pfb.78.2020.04.03.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 16:57:52 -0700 (PDT)
Date:   Fri, 3 Apr 2020 16:57:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH 1/3] kernel/sysctl: support setting sysctl parameters
 from kernel command line
Message-ID: <202004031654.C4389A04EF@keescook>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
 <20200402205932.GM11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402205932.GM11244@42.do-not-panic.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 02, 2020 at 08:59:32PM +0000, Luis Chamberlain wrote:
> On Thu, Apr 02, 2020 at 10:23:13AM -0700, Kees Cook wrote:
> > On Thu, Apr 02, 2020 at 04:04:42PM +0000, Luis Chamberlain wrote:
> > > On Wed, Apr 01, 2020 at 01:01:47PM +0200, Vlastimil Babka wrote:
> > > > On 3/31/20 12:44 AM, Luis Chamberlain wrote:
> > > > >> +	} else if (wret != len) {
> > > > >> +		pr_err("Wrote only %ld bytes of %d writing to proc file %s to set sysctl parameter '%s=%s'",
> > > > >> +			wret, len, path, param, val);
> > > > >> +	}
> > > > >> +
> > > > >> +	err = filp_close(file, NULL);
> > > > >> +	if (err)
> > > > >> +		pr_err("Error %pe closing proc file to set sysctl parameter '%s=%s'",
> > > > >> +			ERR_PTR(err), param, val);
> > > > >> +out:
> > > > >> +	kfree(path);
> > > > >> +	return 0;
> > > > >> +}
> > > > >> +
> > > > >> +void do_sysctl_args(void)
> > > > >> +{
> > > > >> +	char *command_line;
> > > > >> +	struct vfsmount *proc_mnt = NULL;
> > > > >> +
> > > > >> +	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> > > > > 
> > > > > can you use kstrndup() ? And then use kfree_const()? Yes, feel free to
> > > > 
> > > > I don't follow, what am I missing? Do you mean this?
> > > > 
> > > > size_t len = strlen(saved_command_line);
> > > > command_line = kstrndup(saved_command_line, len, GFP_KERNEL);
> > > > 
> > > > What would be the advantage over plain kstrdup()?
> > > > As for kfree_const(), when would command_line be .rodata? I don't see using
> > > > kstrndup() resulting in that.
> > > 
> > > The const nature of using kstrdup() comes with using const for your
> > > purpose. ie:
> > > 
> > > const char *const_command_line = saved_command_line;
> > > 
> > > The point of a kstrncpy() then is to ensure force a const throughout
> > > your use if you know you don't need modifications.
> > 
> > I'm not following this suggestion. It _is_ modifying it. That's why it's
> > making a copy. What am I missing?
> 
> We modify the copied bootparams to allow new sysctls to map to old boot params?
> 
> If so, then yes, this cannot be used.

I feel like I've lost track of this thread. This strdup is so that the
command line can have '\0's injected while it steps through the args
(and for doing the . and / replacement). I don't know what you mean by
"map" here: this is standard parse_args() usage.

> > > > >> +	parse_args("Setting sysctl args", command_line,
> > > > >> +		   NULL, 0, -1, -1, &proc_mnt, process_sysctl_arg);
> > > > >> +
> > > > >> +	if (proc_mnt)
> > > > >> +		kern_unmount(proc_mnt);
> > > > >> +
> > > > >> +	kfree(command_line);
> > > > >> +}
> > > > > 
> > > > > Then, can we get this tested as part of lib/test_sysctl.c with its
> > > > > respective tools/testing/selftests/sysctl/sysctl.sh ?
> > > > 
> > > > Hmm so I add some sysctl to the test "module" (in fact the 'config' file says it
> > > > should be build with 'y', which would be needed anyway) and expand the test
> > > > instructions so that the test kernel boot has to include it on the command line,
> > > > and then I verify it has been set? Or do you see a better way?
> > > 
> > > We don't necessarily have a way to test the use boot params today.
> > > That reveals an are which we should eventually put some focus on
> > > in the future. In the meantime we have to deal with what we have.
> > > 
> > > So let's think about this:
> > > 
> > > You are adding a new cmdline sysctl boot param, and also a wrapper
> > > for those old boot bootparams to also work using both new sysctl
> > > path and old path. Testing just these both should suffice.
> > > 
> > > How about this:
> > > 
> > > For testing the new feature you are adding, can you extend the default
> > > boot params *always* if a new CONFIG_TEST_SYSCTL_CMDLINE is set? Then
> > > upon boot we can verify the proc handlers for these new boot params got
> > > kicked, and likewise some other proc handlers which also can be used
> > > from the cmdline are *not* set. For this later set, we already have
> > > a series of test syctls you can use. In fact, you can use the existing
> > > syctls for both cases already I believe, its just a matter of adding
> > > this new CONFIG_TEST_SYSCTL_CMDLINE which would extend the cmdline,
> > > and these tests would take place *first* on the script.
> > 
> > This seems... messy.
> 
> It is all we have.
> > I'm all for testing this,
> 
> OK so we do want to test it.
> 
> > but I'd rather this not be internally driven.
> 
> This is the least cumbersome solution I could think of. Other things
> would require things like using qemu, etc. That seems much more messsy.

Yes. Doing an internal extension isn't testing the actual code.

> 
> > This is an external interface (boot params), so
> > I'd rather an external driver handle that testing. We don't have a
> > common method to do that with the kernel, though.
> 
> Right... which begs the question now -- how do we test this sort of
> stuff? The above would at least get us coverage while we iron something
> more generic out for boot params.
> 
> > > That would test both cases with one kernel.
> > > 
> > > You could then also add a bogus new sysctl which also expands to a silly
> > > raw boot param to test the wrapper you are providing. That would be the
> > > only new test syctl you would need to add.
> > 
> > Sure, that seems reasonable. Supporting externally driven testing makes
> > sense for this.
> 
> But again, what exactly?

I don't think anything is needed for this series. It can be boot tested
manually.

-- 
Kees Cook
