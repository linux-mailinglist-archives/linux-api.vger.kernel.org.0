Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F90E2505
	for <lists+linux-api@lfdr.de>; Wed, 23 Oct 2019 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404672AbfJWVQx (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 17:16:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404500AbfJWVQx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 17:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571865412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snJFgOZbu4i8c8zLhe2xRcBcKN6rUZj5lgdiRZc1B7U=;
        b=ESlB8Qq8eyqWN6uCY1cPQ+hUOeVSTfOfptKSzKOoKoaUyNaIAv6BhFszLadAYSMJrZvgNB
        n61X/sMt0Qv6k/6lLgNBSLyF/X9OqracCKAwDaNhSt6rLGbRziEh8pE3fi+3efSuWCX9nA
        yhOcDin/qqWzBvMosjqlYBCz0wGC4Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-334rU2PCPQWzBv-tm3PU8w-1; Wed, 23 Oct 2019 17:16:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0E0801E66;
        Wed, 23 Oct 2019 21:16:46 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 83CEF61F21;
        Wed, 23 Oct 2019 21:16:46 +0000 (UTC)
Date:   Wed, 23 Oct 2019 17:16:45 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Jann Horn <jannh@google.com>,
        Daniel Colascione <dancol@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Nick Kralevich <nnk@google.com>,
        Nosh Minwalla <nosh@google.com>,
        Tim Murray <timmurray@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 3/7] Add a UFFD_SECURE flag to the userfaultfd API.
Message-ID: <20191023211645.GC9902@redhat.com>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com>
 <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 334rU2PCPQWzBv-tm3PU8w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 12:21:18PM -0700, Andy Lutomirski wrote:
> There are two things going on here.
>=20
> 1. Daniel wants to add LSM labels to userfaultfd objects.  This seems
> reasonable to me.  The question, as I understand it, is: who is the
> subject that creates a uffd referring to a forked child?  I'm sure
> this is solvable in any number of straightforward ways, but I think
> it's less important than:

The new uffd created during fork would definitely need to be accounted
on the criu monitor, nor to the parent nor the child, so it'd need to
be accounted to the process/context that has the fd in its file
descriptors array. But since this is less important let's ignore this
for a second.

> 2. The existing ABI is busted independently of #1.  Suppose you call
> userfaultfd to get a userfaultfd and enable UFFD_FEATURE_EVENT_FORK.
> Then you do:
>=20
> $ sudo <&[userfaultfd number]
>=20
> Sudo will read it and get a new fd unexpectedly added to its fd table.
> It's worse if SCM_RIGHTS is involved.

So the problem is just that a new fd is created. So for this to turn
out to a practical issue, it requires finding a reckless suid that
won't even bother checking the return value of the open/socket
syscalls or some equivalent fd number related side effect. All right
that makes more sense now and of course I agree it needs fixing.

> So I think we either need to declare that UFFD_FEATURE_EVENT_FORK is
> only usable by global root or we need to remove it and maybe re-add it
> in some other form.

If I had a time machine, I'd rather prefer to do the below:

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index fe6d804a38dc..574062051678 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -1958,7 +1958,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 =09=09return -ENOMEM;
=20
 =09refcount_set(&ctx->refcount, 1);
-=09ctx->flags =3D flags;
+=09ctx->flags =3D flags | UFFD_CLOEXEC;
 =09ctx->features =3D 0;
 =09ctx->state =3D UFFD_STATE_WAIT_API;
 =09ctx->released =3D false;

I mean there's no strong requirement to allow any uffd to survive exec
even if UFFD_FEATURE_EVENT_FORK never existed, it's enough if it can
be passed through unix domain sockets.

Until UFFD_FEATURE_EVENT_FORK come around, there was no particular
reason to implicitly enforce O_CLOEXEC on all uffd, it was totally
possible to clone() and exec() to pass the fd to a different
process. So it never rang a bell that this would turn out to be a
problem after UFFD_FEATURE_EVENT_FORK was introduced.

There are various ways to approach this:

1) drop all non cooperative features and mark their feature bitflags
   reserved (no ABI break)

2) enforce UFFD_CLOEXEC with above patch (potential ABI break all
   userfaultfd users)

3) enforce UFFD_CLOEXEC if UFFD_FEATURE_EVENT_FORK is set (ABI break
   only if UFFD_FEATURE_EVENT_FORK is set). Note all forked uffd
   are opened with the same flags inherited from the original uffd.

4) enforce the global root permission check when creating the uffd only if
   UFFD_FEATURE_EVENT_FORK is set.

5) drop all non cooperative features from API 0xaa and introduce API
   0xab with the features back, but with UFFD_CLOEXEC implicitly
   enforced and with UFFD_CLOEXEC forbidden to be set in the flags

6) stick to API 0xaa and drop only UFFD_FEATURE_EVENT_FORK, but add a
   UFFD_FEATURE_EVENT_FORK2 that requires UFFD_CLOEXEC to be set
   (instead of implicitly enforcing it)

7) stick to API 0xaa and drop only UFFD_FEATURE_EVENT_FORK, but add a
   UFFD_FEATURE_EVENT_FORK2 that does the global root permission check=20


5 is the non-ABI-break version of 2.

6 is the non-ABI-break version of 3.

7 is the non-ABI-break version of 4.

My favorite is 1) for the reason explained in the previous email.

However if postcopy live migration of bare metal containers already
runs in production anywhere or is at least very close to reach that
milestone or if the non-cooperative features are used in production in
any other way, we'd like to know where and in such case that will
totally change my mind about it. In such case I'd suggest to pick any
of the other options except 1).

In short there shall be good reason for going through further
maintenance burden.

Thanks,
Andrea

