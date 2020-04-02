Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C43219CC2E
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388991AbgDBU7g (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:59:36 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35620 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBU7f (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:59:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id c12so1819725plz.2;
        Thu, 02 Apr 2020 13:59:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0E1gU86DMMmY3TlJlUrGFci/4+h2XPiJTo24Taxnmhk=;
        b=hGWYuylquG1JcHqkKl3SuE8RzsSvOp6AxmWbJf0ApEz3IfY1yVEPWaOM3+PAX0Qimd
         uxcezioRxTYyPol2qm6U21+8QtSggBQyqClGpbkx0ECh0Ana4Pspfa9dGU0nMcfkStgF
         4wdISQWe1oH8Y22JjWipnKunrElhBWVE9LZwkgk4rO2VqvFhmlWJxLjtua7JtZgSpOOD
         vd+KVehUbqp5ucL/5ko9iTAM39sW1K515dm/j2CIInkhfq3uZSpNvSqzDaZsPeeLY0wQ
         C5l8yw+bRofBOgReVJ+3ZnekUKF2kJAqurCqcynCS1rZtesRMOWKswxGVVR0PzcsV+7h
         WK/Q==
X-Gm-Message-State: AGi0PuZweXGcAXZgWGmyXmNV6qRSNg/karrxyjTV4PRZstBcyDSeqypT
        vfKMZtSYbOeO3fN9FG4wFIE=
X-Google-Smtp-Source: APiQypKKENrG0wlOjGqKZJ5An1gkwndU6fVXfEAr9ac0JndRmthMNo4kt+ZCJgtgyWpgIS5PNL79jQ==
X-Received: by 2002:a17:902:e788:: with SMTP id cp8mr4627731plb.343.1585861174587;
        Thu, 02 Apr 2020 13:59:34 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id x17sm396140pfm.55.2020.04.02.13.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:59:33 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 52AA940254; Thu,  2 Apr 2020 20:59:32 +0000 (UTC)
Date:   Thu, 2 Apr 2020 20:59:32 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200402205932.GM11244@42.do-not-panic.com>
References: <20200330115535.3215-1-vbabka@suse.cz>
 <20200330115535.3215-2-vbabka@suse.cz>
 <20200330224422.GX11244@42.do-not-panic.com>
 <287ac6ae-a898-3e68-c7d8-4c1d17a40db9@suse.cz>
 <20200402160442.GA11244@42.do-not-panic.com>
 <202004021017.3A23B759@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004021017.3A23B759@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 02, 2020 at 10:23:13AM -0700, Kees Cook wrote:
> On Thu, Apr 02, 2020 at 04:04:42PM +0000, Luis Chamberlain wrote:
> > On Wed, Apr 01, 2020 at 01:01:47PM +0200, Vlastimil Babka wrote:
> > > On 3/31/20 12:44 AM, Luis Chamberlain wrote:
> > > >> +	} else if (wret != len) {
> > > >> +		pr_err("Wrote only %ld bytes of %d writing to proc file %s to set sysctl parameter '%s=%s'",
> > > >> +			wret, len, path, param, val);
> > > >> +	}
> > > >> +
> > > >> +	err = filp_close(file, NULL);
> > > >> +	if (err)
> > > >> +		pr_err("Error %pe closing proc file to set sysctl parameter '%s=%s'",
> > > >> +			ERR_PTR(err), param, val);
> > > >> +out:
> > > >> +	kfree(path);
> > > >> +	return 0;
> > > >> +}
> > > >> +
> > > >> +void do_sysctl_args(void)
> > > >> +{
> > > >> +	char *command_line;
> > > >> +	struct vfsmount *proc_mnt = NULL;
> > > >> +
> > > >> +	command_line = kstrdup(saved_command_line, GFP_KERNEL);
> > > > 
> > > > can you use kstrndup() ? And then use kfree_const()? Yes, feel free to
> > > 
> > > I don't follow, what am I missing? Do you mean this?
> > > 
> > > size_t len = strlen(saved_command_line);
> > > command_line = kstrndup(saved_command_line, len, GFP_KERNEL);
> > > 
> > > What would be the advantage over plain kstrdup()?
> > > As for kfree_const(), when would command_line be .rodata? I don't see using
> > > kstrndup() resulting in that.
> > 
> > The const nature of using kstrdup() comes with using const for your
> > purpose. ie:
> > 
> > const char *const_command_line = saved_command_line;
> > 
> > The point of a kstrncpy() then is to ensure force a const throughout
> > your use if you know you don't need modifications.
> 
> I'm not following this suggestion. It _is_ modifying it. That's why it's
> making a copy. What am I missing?

We modify the copied bootparams to allow new sysctls to map to old boot params?

If so, then yes, this cannot be used.

> > > >> +	parse_args("Setting sysctl args", command_line,
> > > >> +		   NULL, 0, -1, -1, &proc_mnt, process_sysctl_arg);
> > > >> +
> > > >> +	if (proc_mnt)
> > > >> +		kern_unmount(proc_mnt);
> > > >> +
> > > >> +	kfree(command_line);
> > > >> +}
> > > > 
> > > > Then, can we get this tested as part of lib/test_sysctl.c with its
> > > > respective tools/testing/selftests/sysctl/sysctl.sh ?
> > > 
> > > Hmm so I add some sysctl to the test "module" (in fact the 'config' file says it
> > > should be build with 'y', which would be needed anyway) and expand the test
> > > instructions so that the test kernel boot has to include it on the command line,
> > > and then I verify it has been set? Or do you see a better way?
> > 
> > We don't necessarily have a way to test the use boot params today.
> > That reveals an are which we should eventually put some focus on
> > in the future. In the meantime we have to deal with what we have.
> > 
> > So let's think about this:
> > 
> > You are adding a new cmdline sysctl boot param, and also a wrapper
> > for those old boot bootparams to also work using both new sysctl
> > path and old path. Testing just these both should suffice.
> > 
> > How about this:
> > 
> > For testing the new feature you are adding, can you extend the default
> > boot params *always* if a new CONFIG_TEST_SYSCTL_CMDLINE is set? Then
> > upon boot we can verify the proc handlers for these new boot params got
> > kicked, and likewise some other proc handlers which also can be used
> > from the cmdline are *not* set. For this later set, we already have
> > a series of test syctls you can use. In fact, you can use the existing
> > syctls for both cases already I believe, its just a matter of adding
> > this new CONFIG_TEST_SYSCTL_CMDLINE which would extend the cmdline,
> > and these tests would take place *first* on the script.
> 
> This seems... messy.

It is all we have.


> I'm all for testing this,

OK so we do want to test it.

> but I'd rather this not be internally driven.

This is the least cumbersome solution I could think of. Other things
would require things like using qemu, etc. That seems much more messsy.

> This is an external interface (boot params), so
> I'd rather an external driver handle that testing. We don't have a
> common method to do that with the kernel, though.

Right... which begs the question now -- how do we test this sort of
stuff? The above would at least get us coverage while we iron something
more generic out for boot params.

> > That would test both cases with one kernel.
> > 
> > You could then also add a bogus new sysctl which also expands to a silly
> > raw boot param to test the wrapper you are providing. That would be the
> > only new test syctl you would need to add.
> 
> Sure, that seems reasonable. Supporting externally driven testing makes
> sense for this.

But again, what exactly?

  Luis
