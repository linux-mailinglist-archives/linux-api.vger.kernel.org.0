Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23E541772EA
	for <lists+linux-api@lfdr.de>; Tue,  3 Mar 2020 10:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgCCJsN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Mar 2020 04:48:13 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40067 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgCCJsN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Mar 2020 04:48:13 -0500
Received: by mail-io1-f66.google.com with SMTP id m22so2843626ioj.7
        for <linux-api@vger.kernel.org>; Tue, 03 Mar 2020 01:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tmUyb7I5QZ5m7l+map6/TTENM00J/X4NTs6U2t9bq9A=;
        b=UnASBZv2HlRYHTnSbEdv3S4dGBVCqpFO4bwftl15quBrWH6ERWwR//dlevRkFdHY8u
         Y1NGzPTLB9xA+UewKqkD/sN3CSE6cUYJqxDKljs3apGO9RPeOZ5k4nfs7l8GKFHMahrT
         564xMuqnPGrSdkI6+TAepvlKpFkwSitRCuoro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tmUyb7I5QZ5m7l+map6/TTENM00J/X4NTs6U2t9bq9A=;
        b=YkYdk99FmM4NOUG0pDxQ9K/HPM8u3QSiW/r2llIfllZGOm1lfKkUj1AqMC59Eet3Om
         yykYoXHDw2RT14eOUGPPdfbgCwj948o0TTIjUJFGH4/ErrgTXfW+8yfGE7HP+r0xDC9s
         Wd7lME3bSb3yKiULvXd+Px4SFTUxKYkMOD15eIb2I5ubUP0YsZPJLDfgYQaEUgRy12mz
         pK19xQl43ySfYIGdj7JXu7jxWRl8AigQc/i+zdqlWZv1kJWe1xPKXiks8Epq1XQZIOUn
         KRn5uLy/7fMAeGh8Gr3i+1sZ1mOw73tg1EqbSKO1VL8IClrEYj3YzikVSknGSrRWCh0w
         r6Ow==
X-Gm-Message-State: ANhLgQ2jIYPlnBPv/o1917dTqGgTKr19Xk3h0DiLMuCMJ5AECWW6Z2fk
        Icge1Lw0dMi/n1j8cgvUBJZ96SowotoQmMzoxUDAYg==
X-Google-Smtp-Source: ADFU+vvvtLDcbP4JULdPm70drjm3KqEySXTBU2b4yubEl0GoNv8K14LSHW2jEphUEwc0usp5xzdPCj2rr+ecQM93dBg=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr3126436jac.77.1583228892582;
 Tue, 03 Mar 2020 01:48:12 -0800 (PST)
MIME-Version: 1.0
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
 <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
 <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com>
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk>
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
 <1509948.1583226773@warthog.procyon.org.uk> <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
In-Reply-To: <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 3 Mar 2020 10:48:01 +0100
Message-ID: <CAJfpegtemv64mpmTRT6ViHmsWq4nNE4KQvuHkNCYozRU7dQd8Q@mail.gmail.com>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
To:     David Howells <dhowells@redhat.com>
Cc:     Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 3, 2020 at 10:26 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
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

BTW, I do feel that there's room for improvement in userspace code as
well.  Even quite big mount table could be scanned for *changes* very
efficiently.  l.e. cache previous contents of /proc/self/mountinfo and
compare with new contents, line-by-line.  Only need to parse the
changed/added/removed lines.

Also it would be pretty easy to throttle the number of updates so
systemd et al. wouldn't hog the system with unnecessary processing.

Thanks,
Miklos
