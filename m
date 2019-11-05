Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A58B0F041B
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 18:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390181AbfKERab (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 12:30:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730943AbfKERaa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 12:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572975029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R4CAvK29IQ9BTMooH1oXZfErhOK7uWCBlP8KR7GiQus=;
        b=RzvGG4JRu8vgkLcsxwo8Ax3RWQ0bgvRYomH4cjX4HKOmmwyvj9VS+pvB+qXL0Hp9jac4Lw
        7PHFylyeKzYt8j8ZEHk1YJ3E65mkR30Ikw+7QjvSSsgRRu+kBtnmAfb5sxmjfxkNOdnmSt
        8U1gIUTq8IIuo9L9Lrc1gz6iX9kCofI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-jGWJEnvkP0WG-IUuzHi1ZA-1; Tue, 05 Nov 2019 12:30:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C945107ACC3;
        Tue,  5 Nov 2019 17:30:24 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D666619C6A;
        Tue,  5 Nov 2019 17:30:23 +0000 (UTC)
Date:   Tue, 5 Nov 2019 12:30:23 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20191105173023.GN30717@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
 <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
 <20191105163316.GI30717@redhat.com>
 <CAKOZuet1Hrdd7U4VVBmXNCkE6xwiUPERRHjP=A3bX6B9A4BQRQ@mail.gmail.com>
 <20191105165556.GK30717@redhat.com>
 <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZuet+fgaJR72YwYrHFdFVSOo6EWpcT8jUoh7se4cZb0V2aw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jGWJEnvkP0WG-IUuzHi1ZA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 05, 2019 at 09:02:09AM -0800, Daniel Colascione wrote:
> And you're suggesting making a security check work weirdly unlike most
> other security checks because you hope it'll get removed one day?

I didn't actually suggest that, I was only asking clarifications that
I understood correctly because up until that point you didn't seem to
say that the "permission check" needs to remain in UFFDIO_API.

> Temporary solutions aren't, and if something goes into the kernel at
> all, it's worth getting right. The general rule is that access checks
> happen at open time. The kernel has already been bitten by UFFD
> exempting itself from the normal rules (e.g., the
> read(2)-makes-a-file-descriptor thing) in the name of expediency.
> There shouldn't be any more exceptions.

It didn't occur to me that not doing the measurement in the syscall
that opens an fd is weird.

The posted patch doesn't work any different than fscrypt_ioctl_add_key
in FS_IOC_ADD_ENCRYPTION_KEY of ext4 and others, or
btrfs_ioctl_fssetxattr or a ton of other examples where permissions
are checked directly the in ioctl of the files and the measurement is
also done in the ioctl and not in the open() as you suggest as the
only non-weird solution that should exist in the kernel.

I can surely provide a lot more examples of the exact same paradigm
where the measurement of the capability is done in the ioctl, those
are the first two examples that show up so it's unlikely they're the
only ones.

So overall I didn't think this was something wrong to do, or weird or
something particularly new and I didn't look like we were bitting
anything with it. And more than in the name of expediency this simply
looks preferable to keep the complexity of the kernel low which in
turns it means it's going to be more secure and simpler to
maintain. Especially considering this code is likely to be modified
later.

Said that I've nothing contrary to do the more complex solution if
that's the correct thing to do despite more complex and despite the
code is pending for removal anyway, just I don't see any difference
between the current simple patch to what ext4_ioctl does in
FS_IOC_ADD_ENCRYPTION_KEY + FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR.

