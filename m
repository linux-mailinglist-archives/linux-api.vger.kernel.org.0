Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6C177354
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 11:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgCCKA6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 05:00:58 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:36546 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728005AbgCCKA6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 05:00:58 -0500
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1j94M2-0002Iv-H5; Tue, 03 Mar 2020 10:00:46 +0000
Date:   Tue, 3 Mar 2020 11:00:45 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>, Ian Kent <raven@themaw.net>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver
 #17]
Message-ID: <20200303100045.zqntjjjv6npvs5zl@wittgenstein>
References: <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
 <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein>
 <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk>
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 03, 2020 at 10:26:21AM +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:
> >
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> >
> > > I'm doing a patch.   Let's see how it fares in the face of all these
> > > preconceptions.
> >
> > Don't forget the efficiency criterion.  One reason for going with fsinfo(2) is
> > that scanning /proc/mounts when there are a lot of mounts in the system is
> > slow (not to mention the global lock that is held during the read).
> >
> > Now, going with sysfs files on top of procfs links might avoid the global
> > lock, and you can avoid rereading the options string if you export a change
> > notification, but you're going to end up injecting a whole lot of pathwalk
> > latency into the system.
> 
> Completely irrelevant.  Cached lookup is so much optimized, that you
> won't be able to see any of it.
> 
> No, I don't think this is going to be a performance issue at all, but
> if anything we could introduce a syscall
> 
>   ssize_t readfile(int dfd, const char *path, char *buf, size_t
> bufsize, int flags);
> 
> that is basically the equivalent of open + read + close, or even a
> vectored variant that reads multiple files.  But that's off topic
> again, since I don't think there's going to be any performance issue
> even with plain I/O syscalls.
> 
> >
> > On top of that, it isn't going to help with the case that I'm working towards
> > implementing where a container manager can monitor for mounts taking place
> > inside the container and supervise them.  What I'm proposing is that during
> > the action phase (eg. FSCONFIG_CMD_CREATE), fsconfig() would hand an fd
> > referring to the context under construction to the manager, which would then
> > be able to call fsinfo() to query it and fsconfig() to adjust it, reject it or
> > permit it.  Something like:
> >
> >         fd = receive_context_to_supervise();
> >         struct fsinfo_params params = {
> >                 .flags          = FSINFO_FLAGS_QUERY_FSCONTEXT,
> >                 .request        = FSINFO_ATTR_SB_OPTIONS,
> >         };
> >         fsinfo(fd, NULL, &params, sizeof(params), buffer, sizeof(buffer));
> >         supervise_parameters(buffer);
> >         fsconfig(fd, FSCONFIG_SET_FLAG, "hard", NULL, 0);
> >         fsconfig(fd, FSCONFIG_SET_STRING, "vers", "4.2", 0);
> >         fsconfig(fd, FSCONFIG_CMD_SUPERVISE_CREATE, NULL, NULL, 0);
> >         struct fsinfo_params params = {
> >                 .flags          = FSINFO_FLAGS_QUERY_FSCONTEXT,
> >                 .request        = FSINFO_ATTR_SB_NOTIFICATIONS,
> >         };
> >         struct fsinfo_sb_notifications sbnotify;
> >         fsinfo(fd, NULL, &params, sizeof(params), &sbnotify, sizeof(sbnotify));
> >         watch_super(fd, "", AT_EMPTY_PATH, watch_fd, 0x03);
> >         fsconfig(fd, FSCONFIG_CMD_SUPERVISE_PERMIT, NULL, NULL, 0);
> >         close(fd);
> >
> > However, the supervised mount may be happening in a completely different set
> > of namespaces, in which case the supervisor presumably wouldn't be able to see
> > the links in procfs and the relevant portions of sysfs.
> 
> It would be a "jump" link to the otherwise invisible directory.

More magic links to beam you around sounds like a bad idea. We had a
bunch of CVEs around them in containers and they were one of the major
reasons behind us pushing for openat2(). That's why it has a
RESOLVE_NO_MAGICLINKS flag.

Christian
