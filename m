Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9101438CE68
	for <lists+linux-api@lfdr.de>; Fri, 21 May 2021 21:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhEUTy3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 May 2021 15:54:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30055 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232329AbhEUTy3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 May 2021 15:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621626785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rd7aBdUBcJU5e73kh0RzNbu6ZJ9O6h0P4KiP1d1uEE0=;
        b=LdNRmjmHtsWrBfCJWnkK/r8b5nTWt7IQFLI6JICJEDfu0UHLbgUNDs+I1Gl/8MFfO8e2WL
        Pe2y39cFedCtGGIUMZjBLCwZoydmj6m9eIvW3jGQbHFtRYGnQAncua11FVKWBjz19XsayX
        4b/DI2Gk+AHm8HCkKthUbv6cHxqD3U8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-xiODTFq5OL6mKm77bkx2OQ-1; Fri, 21 May 2021 15:52:58 -0400
X-MC-Unique: xiODTFq5OL6mKm77bkx2OQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AAEEF801817;
        Fri, 21 May 2021 19:52:56 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-113-228.ams2.redhat.com [10.36.113.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D760119718;
        Fri, 21 May 2021 19:52:53 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Matheus Castanho via Libc-alpha <libc-alpha@sourceware.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Matheus Castanho <msc@linux.ibm.com>, musl@lists.openwall.com,
        "Dmitry V. Levin" <ldv@altlinux.org>, linux-api@vger.kernel.org,
        libc-dev@lists.llvm.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: Linux powerpc new system call instruction and ABI
References: <20200611081203.995112-1-npiggin@gmail.com>
        <20210518231331.GA8464@altlinux.org>
        <1621385544.nttlk5qugb.astroid@bobo.none>
        <1621400263.gf0mbqhkrf.astroid@bobo.none>
        <87a6oo4312.fsf@linux.ibm.com>
Date:   Fri, 21 May 2021 21:52:51 +0200
In-Reply-To: <87a6oo4312.fsf@linux.ibm.com> (Matheus Castanho via Libc-alpha's
        message of "Fri, 21 May 2021 16:40:30 -0300")
Message-ID: <87k0nr6ezw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Matheus Castanho via Libc-alpha:

> From: Nicholas Piggin <npiggin@gmail.com>
> Subject: [PATCH 1/1] powerpc: Fix handling of scv return error codes
>
> When using scv on templated ASM syscalls, current code interprets any
> negative return value as error, but the only valid error codes are in
> the range -4095..-1 according to the ABI.
>
> Reviewed-by: Matheus Castanho <msc@linux.ibm.com>

Please reference bug 27892 in the commit message.  I'd also appreciate a
backport to the 2.33 release branch (where you need to add NEWS manually
to add the bug reference).

Thanks,
Florian

