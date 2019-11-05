Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35391F0302
	for <lists+linux-api@lfdr.de>; Tue,  5 Nov 2019 17:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390549AbfKEQdZ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 5 Nov 2019 11:33:25 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51407 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390402AbfKEQdY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 5 Nov 2019 11:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572971603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Skg5arqhiojkrhAvFDjH124AuiwjgoDeP66mJMAYWGM=;
        b=aaXIS5cPcR2h6HOzCu9vY7K8DyPeKuUiqBvl2dLkBE606kNXn41QqKVJ7JRyQ7Urxl6ibN
        /Ev9pQwmxgq6n2UXyDtNhtxYrOacNndFukWxFKnpFMs0XDY1OC3/6TodRFDORdz5PuYU1T
        Mv/UHRFnrMFGBGZuPGyhDI2a51Ku6Cs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-fdhOjGE1OwGmEEn4AJbycQ-1; Tue, 05 Nov 2019 11:33:20 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D34D01800D4A;
        Tue,  5 Nov 2019 16:33:17 +0000 (UTC)
Received: from mail (ovpn-121-157.rdu2.redhat.com [10.10.121.157])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CC2160C88;
        Tue,  5 Nov 2019 16:33:17 +0000 (UTC)
Date:   Tue, 5 Nov 2019 11:33:16 -0500
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
Message-ID: <20191105163316.GI30717@redhat.com>
References: <1572967777-8812-1-git-send-email-rppt@linux.ibm.com>
 <1572967777-8812-2-git-send-email-rppt@linux.ibm.com>
 <CAKOZuev93zDGNPX+ySg_jeUg4Z3zKMcpABekUQvHA01kTVn4=A@mail.gmail.com>
 <CALCETrX=VmSjD6kLT6tuZQ4Efhc_13vZrw1mo4Z2iKqZTT-bzg@mail.gmail.com>
 <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKOZuetu0QWUDAycTOFzC4HEbjH99EtOhb4gJnHAuovT_StpzA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: fdhOjGE1OwGmEEn4AJbycQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Nov 05, 2019 at 08:06:49AM -0800, Daniel Colascione wrote:
> Sure, but the same argument applies to all the other permission checks
> that we do at open time, not at ioctl time. For better or for worse,
> the DAC-ish model used in most places is that access checks happen at
> file object creation time and anyone who has the FD can perform those
> operations later. Confusing the model by doing *some* permission
> checks at open time and *some* permission checks at usage time makes
> the system harder to understand.

The only case that requires change is if userland requested the
UFFD_FEATURE_EVENT_FORK feature (which AFIK only CRIU does) and that
request is done in the UFFDIO_API call not during the syscall.

Doing the check in the syscall would then break all non privileged
users like if we'd set /proc/sys/vm/unprivileged_userfaultfd to
zero. Qemu for example rightfully never runs with privilege (with a
few exceptions like Kata which should be fixed in fact) and it never
asks for the UFFD_FEATURE_EVENT_FORK feature either.

