Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71428F3891
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 20:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfKGT2E (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 14:28:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40994 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbfKGT2E (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 14:28:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573154882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5GOtSEPvdxYm2pxjUsA4qBhfGS9ZCElHaPyIXVtMmQI=;
        b=YqhmYVEW2e/W1KswTW11LGB6KjIrOS3H2tg14Dx7dbIMFxfNWfcblKfNVKfqNWDo6bZoUc
        o8nTPPNLooGFv5cnVDltRR9tQS68QaJpWpEwO9k/yFZKMDRfOnndDjGMgYrZjJbfKURgbU
        MDhU17zI6EkaRL75+bQB3iJtZ2ijx9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-F77lJWRLMVywhZ5pj1TsMQ-1; Thu, 07 Nov 2019 14:27:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44B3F1005500;
        Thu,  7 Nov 2019 19:27:56 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DF045E240;
        Thu,  7 Nov 2019 19:27:56 +0000 (UTC)
Date:   Thu, 7 Nov 2019 14:27:55 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Daniel Colascione <dancol@google.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20191107192755.GM17896@redhat.com>
References: <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <20191105162424.GH30717@redhat.com>
 <CAKOZuet=g++G+biSP5bU-Rppu6fykU1TVUDj20NapqAYQY4r9A@mail.gmail.com>
 <20191107083902.GB3247@linux.ibm.com>
 <CAKOZuevhEXpMr49KmkBLEyMGsDz8WujKvOGCty8+p7cwVbmoXA@mail.gmail.com>
 <20191107153801.GF17896@redhat.com>
 <CAKOZueuKttjyRBgMkaBknzn+fzufZA+gJcd5wnKgiwmO37yN1g@mail.gmail.com>
 <20191107182259.GK17896@redhat.com>
 <CAKOZueubtyuTZC5zPTL3qDpVS5RFYFMqx727Bj4fjMHDSY5rMg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZueubtyuTZC5zPTL3qDpVS5RFYFMqx727Bj4fjMHDSY5rMg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: F77lJWRLMVywhZ5pj1TsMQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Nov 07, 2019 at 10:50:26AM -0800, Daniel Colascione wrote:
> On Thu, Nov 7, 2019 at 10:23 AM Andrea Arcangeli <aarcange@redhat.com> wr=
ote:
> > Not all software will do this after calling recvmsg:
> >
> >     if (cmsg->cmsg_type =3D=3D SCM_RIGHTS) {
> >       /* oops we got attacked and an fd was involountarily installed
> >          because we received another AF_UNIX from a malicious attacker
> >          in control of the other end of the SCM_RIGHTS-receiving
> >          AF_UNIX connection instead of our expected socket family
> >          which doesn't even support SCM_RIGHTS so we would never have
> >          noticed an fd was installed after recvmsg */
> >     }
>=20
> If a program omits this code after calling recvmsg on a file
> descriptor of unknown provenance and the program breaks, it's the
> program's fault. [..]

Hmm, ok, would it be possible to do a research effort and check how
much software that receives an fd through SCM_RIGHTS and then calls
recvmsg on it, always remembers to follow the recvsmg with a if
(cmsg->cmsg_type =3D=3D SCM_RIGHTS) path that closes the involuntarily
opened fd?

Frankly until today, I didn't realize that not adding a specialized
"cmsg->cmsg_type =3D=3D SCM_RIGHTS" check after every recvmsg executed on
any fd received with SCM_RIGHTS, was a program's fault and it made the
program vulnerable (non robust) from an attack from the other end of
the AF_UNIX pipe just like if the program issued a read() with uffd
event fork being sent through SCM_RIGHTS (except in that case it
wasn't program's fault because read had not to install the fd while
recvmsg can always install fd if cmsg_type =3D=3D SCM_RIGHTS is returned).

The main argument in favor of recvmsg would be that even if we use it
for uffd too, it won't make recvmsg on an fd received from SCM_RIGHTS
any less secure than it already is, but it's not exactly an example of
robustness in terms of API if it's a program's fault if it doesn't
follow every recvmsg with the above quoted check.

The ioctl is much more robust because there's no chance that somebody
can be attacked by forgetting a specialized non intuitive check after
calling the specialized ioctl that installs the fd.

Thanks,
Andrea

