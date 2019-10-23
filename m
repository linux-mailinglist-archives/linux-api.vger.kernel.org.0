Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF942E2685
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 00:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407983AbfJWWlU (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 18:41:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2407982AbfJWWlU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 18:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571870478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R50buRVrn/+GqCN9rIMZeiktwzXqouQE71vrZXkoKqg=;
        b=MWOz322uo5ucXMG/8/owgPzHCCDVtj+eJfU2DenAqHDe0YKmI5leY1OU4/QQ5oxEUfto0D
        bBxa/PDBqbcUrAMqdB6551ZRLKC7ptJC3U35SLHL5dWRz0Glkj3HJRquLjuqlcHrsNq9zu
        rAKzZo3HwkSU5tmr6N5PE0gvsrhk4KM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-yudhefuFML6XgqdUrkpLsA-1; Wed, 23 Oct 2019 18:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EDF31800D6B;
        Wed, 23 Oct 2019 22:41:12 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E53819C77;
        Wed, 23 Oct 2019 22:41:11 +0000 (UTC)
Date:   Wed, 23 Oct 2019 18:41:10 -0400
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
Message-ID: <20191023224110.GE9902@redhat.com>
References: <20191012191602.45649-1-dancol@google.com>
 <20191012191602.45649-4-dancol@google.com>
 <CALCETrVZHd+csdRL-uKbVN3Z7yeNNtxiDy-UsutMi=K3ZgCiYw@mail.gmail.com>
 <CAKOZuevUqs_Oe1UEwguQK7Ate3ai1DSVSij=0R=vmz9LzX4k6Q@mail.gmail.com>
 <CALCETrUyq=J37gU-MYXqLdoi7uH7iNNVRjvcGUT11JA1QuTFyg@mail.gmail.com>
 <CAG48ez3P27-xqdjKLqfP_0Q_v9K92CgEjU4C=kob2Ax7=NoZbA@mail.gmail.com>
 <20191023190959.GA9902@redhat.com>
 <CALCETrWY+5ynDct7eU_nDUqx=okQvjm=Y5wJvA4ahBja=CQXGw@mail.gmail.com>
 <20191023211645.GC9902@redhat.com>
 <CALCETrVS_Ym9wpvTP-ys-OBKCgg7QQjPdhJZe5YXJ6e8JQkNQQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CALCETrVS_Ym9wpvTP-ys-OBKCgg7QQjPdhJZe5YXJ6e8JQkNQQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: yudhefuFML6XgqdUrkpLsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 02:25:35PM -0700, Andy Lutomirski wrote:
> That doesn't solve the problem.  With your time machine, you should

Would you elaborate what problem remains if execve closes all uffd
so that read() cannot run post execve?

> instead use ioctl() or recvmsg().

The event delivery is modeled after eventfd.c per userfaultfd.c header
file, so would then eventfd also need to be converted to ioctl or
recvmsg to deliver its event any better? Initially I evaluated to use
eventfd for it in fact, but it wasn't possible. I didn't look like it
could get any better than eventfd in terms of event delivery.

Or do you refer to single out only the delivery of the UFFD_EVENT_FORK
event not through read()?

> > 4) enforce the global root permission check when creating the uffd only=
 if
> >    UFFD_FEATURE_EVENT_FORK is set.
>=20
> This could work, but we should also add a better way to do
> UFFD_FEATURE_EVENT_FORK and get CRIU to start using it.  If CRIU is
> the only user, we can probably drop the old ABI after a couple of
> releases, since as far as I know, CRIU users need to upgrade their
> CRIU more or less in sync with the kernel so that new kernel features
> get checkpointed and restored.

Getting CRIU stat using it shouldn't be a problem at all, but we'll be
back to square one if you just stop there.

I don't see how to lift those limitations in the wiki to make it
usable in production by just providing a better way to do
UFFD_FEATURE_EVENT_FORK.

If you're volunteering to fix the limitations and make CRIU usable in
production that would be awesome, then of course we should do whatever
possible to improve UFFD_FEATURE_EVENT_FORK.

Thanks,
Andrea

