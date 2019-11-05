Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5C3F029F
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389934AbfKEQYe (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:24:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390163AbfKEQYd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572971071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Al/+c8KHyhxPJlQUXk+cOOY+ajrIwqI170evHk6gx8A=;
        b=CqI1ZXblgRzb+q9/pIvdG6gk6abBEDrZxCTpZSpMA55FPzDfKXcF0WO+A6CofiSowW8Cc1
        Xjdlw8uUiDt7+Tzu+bw58v0TEAlcPBSUgQUINuDLj6j6YdhCENeDOU+geeHZIKXWoIrDxV
        OL8h5ZWKIcy1Xp/+ouIuFYK3kcc4Wkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-4kcvJejoNyy-KkwYcL7N0g-1; Tue, 05 Nov 2019 11:24:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD2C9107ACC3;
        Tue,  5 Nov 2019 16:24:25 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 65A90393B;
        Tue,  5 Nov 2019 16:24:25 +0000 (UTC)
Date:   Tue, 5 Nov 2019 11:24:24 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] userfaultfd: require CAP_SYS_PTRACE for
 UFFD_FEATURE_EVENT_FORK
Message-ID: <20191105162424.GH30717@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
 <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 4kcvJejoNyy-KkwYcL7N0g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 05, 2019 at 08:00:26AM -0800, Andy Lutomirski wrote:
> On Tue, Nov 5, 2019 at 7:55 AM Daniel Colascione <dancol@google.com> wrot=
e:
> >
> > On Tue, Nov 5, 2019 at 7:29 AM Mike Rapoport <rppt@linux.ibm.com> wrote=
:
> > >
> > > Current implementation of UFFD_FEATURE_EVENT_FORK modifies the file
> > > descriptor table from the read() implementation of uffd, which may ha=
ve
> > > security implications for unprivileged use of the userfaultfd.
> > >
> > > Limit availability of UFFD_FEATURE_EVENT_FORK only for callers that h=
ave
> > > CAP_SYS_PTRACE.
> >
> > Thanks. But shouldn't we be doing the capability check at
> > userfaultfd(2) time (when we do the other permission checks), not
> > later, in the API ioctl?
>=20
> The ioctl seems reasonable to me.  In particular, if there is anyone
> who creates a userfaultfd as root and then drop permissions, a later
> ioctl could unexpectedly enable FORK.
>=20
> This assumes that the code in question is only reachable through
> ioctl() and not write().

write isn't implemented. Until UFFDIO_API runs, all other implemented
syscalls are disabled (i.e. all other ioctls, poll and read). You can
quickly verify all the 3 blocks by searching for UFFD_STATE_WAIT_API,

UFFDIO_API is the place where the handshake with userland
happens. userland asks for certain features and the kernel
implementation of userlands answers yes or no.

Normally we would only ever return -EINVAL on a request of a feature
that isn't available in the running kernel (equivalent to -ENOSYS if
the syscall is entirely missing on an even older kernel), -EPERM is
more informative as it tells userland the feature is actually in the
kernel just it requires more permissions.

We could have returned -EINVAL too, but it wouldn't have made a
difference to non-privileged CRIU and we're not aware of other users
that could benefit from -EINVAL instead of -EPERM. This the relevant
CRIU userland:

        if (ioctl(uffd, UFFDIO_API, &uffdio_api)) {
                pr_perror("Failed to get uffd API");
                goto err;
=09}

Unfortunately this is an ABI break, preferred than the clean removal
of the feature, because it's at least not going to break CRIU
deployments running with the PTRACE privilege. The clean removal while
non-ABI breaking, would have prevented all CRIU users to keep running
after a kernel upgrade.

The long term plan is to introduce UFFD_FEATURE_EVENT_FORK2 feature
flag that uses the ioctl to receive the child uffd, it'll consume more
CPU, but it wouldn't require the PTRACE privilege anymore.

Overall any suid or SCM_RIGHTS fd-receiving app, that isn't checking
the retval of open/socket or whatever fd "installing" syscall, is non
robust and is prone to break over time as more people edit the code or
as any library call internally change behavior, so if there's any
practical issue caused by this, it should be fixed in userland
too for higher robustness.

If you stick your userland to std::fs and std::net robustness against
issues like this is enforced by the language.

Thanks,
Andrea

