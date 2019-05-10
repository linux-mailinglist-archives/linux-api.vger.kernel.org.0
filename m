Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9211A577
	for <lists+linux-api@lfdr.de>; Sat, 11 May 2019 00:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfEJWzi (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 10 May 2019 18:55:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45740 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbfEJWzh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 10 May 2019 18:55:37 -0400
Received: by mail-ed1-f65.google.com with SMTP id g57so7177021edc.12
        for <linux-api@vger.kernel.org>; Fri, 10 May 2019 15:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WVJrycbr/gzeELcTlNLGESPEZue/RmnlQ2sNJEpDNsY=;
        b=PVtCvoABifhhpps7LQCxWpbe0cETkuW4407swtpW2wZNB0MYdMM0GxxDqv0HNnNodv
         Ayg8e8drsN5+V97gaXJXhOaknixPfzkzvVcOPyIYII32yga6n2wAaMTThM8259KmS1TC
         xSJrWL+MhMncjrmBTiAaJe/uJL9mtGHSfExT19YLks6SK0rDOxEamgcnb8LEhXqZNBD5
         xaij2B4S8UQV1G46OCEPRl6wk8lJFCRFQ5z0okf/im6T3M/WNhhB1k+bGuD4HbdhzVXX
         8V9EB9KSr9JsFhY3/whaTmkpEOdY5oRlYM0GdJtu+83RR0JobEEwXtgv42WNiUjIl3Gh
         QibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WVJrycbr/gzeELcTlNLGESPEZue/RmnlQ2sNJEpDNsY=;
        b=DMU0beeGBAwvvp5DQgob9/Zk6el/rIcVu4l8SgthwyizpLAbne//1kBAtK9519kdku
         T6feutfmRWG8pzc7/TAJoUCpgopjo4KxEEE6w1PTjhe2w5DIRegakNTHGpzbTWkmZyGQ
         7nAHfP7DyhfAvCBXPHSqFzPsNgxn1PZho9fJdhBC12TwlU3R/OCsjNlvaC2meC3fSz8J
         rpMReabrIHbUtMPcTpe/ojI672D4lf/NQ99MrUpY5LRiL27rVA6b7ZImT93+CrjVZkmX
         O3CdJ7dTvzUZP0Yhwdb61oxC+QgnX4Ldk7btL6o8qPy+OOP8FoSFpukSwzoho0bUUy2b
         j+bw==
X-Gm-Message-State: APjAAAWqPhceTf1IFSvdCXygjv8kX6+W3gYTVT+I7+sTUqYboBfrsfQz
        W0cIhoQ/CSEumAP9zIpITy8qBg==
X-Google-Smtp-Source: APXvYqyFgIAUQN/iwwVHYrlE9ztkC5/Qr3cjj52DwUiZqwb23Y2z2EEJlTmPIu9Z3scX1Cu2fCPrLA==
X-Received: by 2002:a17:906:f91:: with SMTP id q17mr10924134ejj.63.1557528934578;
        Fri, 10 May 2019 15:55:34 -0700 (PDT)
Received: from google.com ([2a00:79e0:1b:201:ee0a:cce3:df40:3ac5])
        by smtp.gmail.com with ESMTPSA id b4sm1767070edf.7.2019.05.10.15.55.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 10 May 2019 15:55:33 -0700 (PDT)
Date:   Sat, 11 May 2019 00:55:27 +0200
From:   Jann Horn <jannh@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190510225527.GA59914@google.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin>
 <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, May 10, 2019 at 02:20:23PM -0700, Andy Lutomirski wrote:
> On Fri, May 10, 2019 at 1:41 PM Jann Horn <jannh@google.com> wrote:
> >
> > On Tue, May 07, 2019 at 05:17:35AM +1000, Aleksa Sarai wrote:
> > > On 2019-05-06, Jann Horn <jannh@google.com> wrote:
> > > > In my opinion, CVE-2019-5736 points out two different problems:
> > > >
> > > > The big problem: The __ptrace_may_access() logic has a special-case
> > > > short-circuit for "introspection" that you can't opt out of; this
> > > > makes it possible to open things in procfs that are related to the
> > > > current process even if the credentials of the process wouldn't permit
> > > > accessing another process like it. I think the proper fix to deal with
> > > > this would be to add a prctl() flag for "set whether introspection is
> > > > allowed for this process", and if userspace has manually un-set that
> > > > flag, any introspection special-case logic would be skipped.
> > >
> > > We could do PR_SET_DUMPABLE=3 for this, I guess?
> >
> > Hmm... I'd make it a new prctl() command, since introspection is
> > somewhat orthogonal to dumpability. Also, dumpability is per-mm, and I
> > think the introspection flag should be per-thread.
> 
> I've lost track of the context here, but it seems to me that
> mitigating attacks involving accidental following of /proc links
> shouldn't depend on dumpability.  What's the actual problem this is
> trying to solve again?

The one actual security problem that I've seen related to this is
CVE-2019-5736. There is a write-up of it at
<https://blog.dragonsector.pl/2019/02/cve-2019-5736-escape-from-docker-and.html>
under "Successful approach", but it goes more or less as follows:

A container is running that doesn't use user namespaces (because for
some reason I don't understand, apparently some people still do that).
An evil process is running inside the container with UID 0 (as in,
GLOBAL_ROOT_UID); so if the evil process inside the container was able
to reach root-owned files on the host filesystem, it could write into
them.

The container engine wants to spawn a new process inside the container.
It forks off a child that joins the container's namespaces (including
PID and mount namespaces), and then the child calls execve() on some
path in the container.
The attacker replaces the executable in the container with a symlink
to /proc/self/exe and replaces a library inside the container with a
malicious one.
When the container engine calls execve(), intending to run an executable
inside the container, it instead goes through ptrace_may_access() using
the introspection short-circuit and re-executes its own executable
through the jumped symlink /proc/self/exe (which is normally unreachable
for the container). After the execve(), the process loads an evil
library from inside the container and is under the control of the
container.
Now the container controls a process whose /proc/self/exe is a jumped
symlink to a host executable, and the container can write into it.

Some container engines are now using an extremely ugly hack to work
around this - whenever they want to enter a container, they copy the
host binary into a new memfd and execute that to avoid exposing the
original host binary to containers:
<https://github.com/opencontainers/runc/commit/0a8e4117e7f715d5fbeef398405813ce8e88558b>


In my opinion, the problems here are:

 - Apparently some people run untrusted containers without user
   namespaces. It would be really nice if people could not do that.
   (Probably the biggest problem here.)
 - ptrace_may_access() has a short-circuit that permits a process to
   unintentionally look at itself even if it has dropped privileges -
   here, it permits the execve("/proc/self/exe", ...) that would
   normally be blocked by the check for CAP_SYS_PTRACE if the process
   is nondumpable.
 - You can use /proc/*/exe to get a writable fd.
