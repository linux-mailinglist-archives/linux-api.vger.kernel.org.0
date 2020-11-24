Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA7B2C2FDA
	for <lists+linux-api@lfdr.de>; Tue, 24 Nov 2020 19:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404008AbgKXSRb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Nov 2020 13:17:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404145AbgKXSRO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Nov 2020 13:17:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606241833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUJObGYPcxmWCt1F5rpzYy+8ynXVUFmmSX89XWvIPx0=;
        b=IBs+2YGDR2hhvilYBLNrT23SHZ6eA45UCPVf5n2IsVVEPSI00bmNbwlSZXXrqE2SIhVO0w
        axjZz04a1/WI1KnHSSMTnVkwDpDaJnT+MgfYzxqzpLT1AEwiCy25X0x65XzQe/NWFOnzPg
        7PFPLet8FUO4d9Z8DRdw4hCRYw3W9Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-kFERPdGdOIaj_Nega45EAA-1; Tue, 24 Nov 2020 13:17:11 -0500
X-MC-Unique: kFERPdGdOIaj_Nega45EAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83A180364D;
        Tue, 24 Nov 2020 18:17:08 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-141.ams2.redhat.com [10.36.112.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F81760BE5;
        Tue, 24 Nov 2020 18:17:02 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Mark Wielaard <mark@klomp.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        dev@opencontainers.org, Jonathan Corbet <corbet@lwn.net>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: Re: [PATCH] syscalls: Document OCI seccomp filter interactions &
 workaround
References: <87lfer2c0b.fsf@oldenburg2.str.redhat.com>
        <20201124122639.x4zqtxwlpnvw7ycx@wittgenstein>
        <878saq3ofx.fsf@oldenburg2.str.redhat.com>
        <dcffcbacbc75086582ea3f073c9e6a981a6dd27f.camel@klomp.org>
        <20201124164546.GA14094@infradead.org>
        <CAG48ez2ZHPavVU3_2VnRADFQstOM1s+3GwfWsRaEjAA1jYcHDg@mail.gmail.com>
        <X70/uPNt2BA/vUSo@kroah.com>
        <CAG48ez2NH2Esw_55JiwK1FAzr_qFFyGaPrE_A=iH=dNuVvY6GQ@mail.gmail.com>
Date:   Tue, 24 Nov 2020 19:17:00 +0100
In-Reply-To: <CAG48ez2NH2Esw_55JiwK1FAzr_qFFyGaPrE_A=iH=dNuVvY6GQ@mail.gmail.com>
        (Jann Horn's message of "Tue, 24 Nov 2020 18:30:28 +0100")
Message-ID: <87h7pezkkj.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Jann Horn:

> But if you can't tell whether the more modern syscall failed because
> of a seccomp filter, you may be forced to retry with an older syscall
> even on systems where the new syscall works fine, and such a fallback
> may reduce security or reliability if you're trying to use some flags
> that only the new syscall provides for security, or something like
> that. (As a contrived example, imagine being forced to retry any
> tgkill() that fails with EPERM as a tkill() just in case you're
> running under a seccomp filter.)

We have exactly this situation with faccessat2 and faccessat today.
EPERM could mean a reject from a LSM, and we really don't want to do our
broken fallback in this case because it will mask the EPERM error from
the LSM (and the sole purpose of faccessat2 is to get that error).

This is why I was so eager to start using faccessat2 in glibc, and we
are now encountering breakage with container runtimes.  Applications
call faccessat (with a non-zero flags argument) today, and they now get
routed to the faccessat2 entry point, without needing recompilation or
anything like that.

We have the same problem for any new system call, but it's different
this time because it affects 64-bit hosts *and* existing applications.

And as I explained earlier, I want to take this opportunity to get
consensus how to solve this properly, so that we are ready for a new
system call where incorrect fallback would definitely reintroduce a
security issue.  Whether it's that ugly probing sequence, a change to
the OCI specification that gets deployed in a reasonable time frame, or
something else that I haven't thought of=E2=80=94I do not have a very strong
preference, although I lean towards the spec change myself.  But I do
feel that we shouldn't throw in a distro-specific patch to paper over
the current faccessat2 issue and forget about it.

Thanks,
Florian
--=20
Red Hat GmbH, https://de.redhat.com/ , Registered seat: Grasbrunn,
Commercial register: Amtsgericht Muenchen, HRB 153243,
Managing Directors: Charles Cachera, Brian Klemm, Laurie Krebs, Michael O'N=
eill

