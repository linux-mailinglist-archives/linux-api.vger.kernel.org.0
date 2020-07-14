Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ECF21ED78
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgGNJ6j (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 05:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29556 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725884AbgGNJ6i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 05:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594720717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1tevPa9X+MuCxM/DtuuMw5c+0nqEV5by4X2ZM7PHae8=;
        b=icKjTHFQTka2uQPhguNi2fLVzJ7STxWwq6VwUDJ/HIWG2SQDTm6Iyj+ioHHNbxmJ+AN4Cw
        HRvHq8oEOb/TL8J2UwpcJzSeXNEGp/+25pBbrcLOjVR8aHcygmWij1EvQjw3SaPfj5Z8Ab
        c6KT8K022kE5k8GkhHre7Bfxru2XbYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-GXHhLnlKMqCVeKX5-K7ZOw-1; Tue, 14 Jul 2020 05:58:33 -0400
X-MC-Unique: GXHhLnlKMqCVeKX5-K7ZOw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 263021009440;
        Tue, 14 Jul 2020 09:58:32 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-246.ams2.redhat.com [10.36.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA93D72E54;
        Tue, 14 Jul 2020 09:58:26 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        carlos@redhat.com
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
Date:   Tue, 14 Jul 2020 11:58:25 +0200
In-Reply-To: <20200714030348.6214-3-mathieu.desnoyers@efficios.com> (Mathieu
        Desnoyers's message of "Mon, 13 Jul 2020 23:03:46 -0400")
Message-ID: <87mu42bepq.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> +	/*
> +	 * Very last field of the structure, to calculate size excluding padding
> +	 * with offsetof().
> +	 */
> +	char end[];
>  } __attribute__((aligned(4 * sizeof(__u64))));

This makes the header incompatible with standard C++.

How are extensions going to affect the definition of struct rseq,
including its alignment?

As things stand now, glibc 2.32 will make the size and alignment of
struct rseq part of its ABI, so it can't really change after that.

With a different approach, we can avoid making the symbol size part of
the ABI, but then we cannot use the __rseq_abi TLS symbol.  As a result,
interoperability with early adopters would be lost.

One way to avoid this problem would be for every library to register its
own rseq area, of the appropriate size.  Then process-wide coordination
in userspace would not be needed.

Thanks,
Florian

