Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5725E2702
	for <lists+linux-api@lfdr.de>; Thu, 24 Oct 2019 01:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392750AbfJWX1Q (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 23 Oct 2019 19:27:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27642 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731522AbfJWX1P (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 23 Oct 2019 19:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571873234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9uVEepBOq08pJMbDSOkJFrN87N15F3Iw6wxc0N8M1KE=;
        b=KEYKKK7hUTyfRiWmfs62fm4FT5W9EMyWWNUGHxrTkZDEt34s53c7lufHV7vwDWgPHDVFtr
        kmetloU2ypTxbY84icY89FDA6rnR3SpmLptU2Kh9WVURBxXSkQeCpJosq3yVsXiG+195bt
        Ng3n0HNhl2peQHaP7krbaQhomyRqgSk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-X7Vm8hDlPiavQGUliB1acg-1; Wed, 23 Oct 2019 19:27:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F8C71005509;
        Wed, 23 Oct 2019 23:27:09 +0000 (UTC)
Received: from mail (ovpn-123-192.rdu2.redhat.com [10.10.123.192])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F342E5C1D4;
        Wed, 23 Oct 2019 23:27:08 +0000 (UTC)
Date:   Wed, 23 Oct 2019 19:27:08 -0400
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
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
Message-ID: <20191023232708.GA433@redhat.com>
References: <20191023224110.GE9902@redhat.com>
 <EB0634BD-AAF4-4805-8178-30FFA94B7B58@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <EB0634BD-AAF4-4805-8178-30FFA94B7B58@amacapital.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: X7Vm8hDlPiavQGUliB1acg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Oct 23, 2019 at 04:01:53PM -0700, Andy Lutomirski wrote:
> Delivering events through read() is just fine. The problem is when
> delivering an event does more than just returning bytes. As far as
> I=E2=80=99ve noticed, uffd=E2=80=99s read() just returns bytes as long as=
 FORK is
> disabled.

Yes, fork is the only case where read doesn't return bytes.

Moving only the fd creation to a separate syscall would then avoid
involuntary creation of the fd.

