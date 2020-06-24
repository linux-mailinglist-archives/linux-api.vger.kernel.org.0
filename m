Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2B2207C1E
	for <lists+linux-api@lfdr.de>; Wed, 24 Jun 2020 21:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406142AbgFXTY3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 24 Jun 2020 15:24:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21109 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405057AbgFXTY2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 24 Jun 2020 15:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593026667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwvLgGG2LaRCgwsWiAA6pHtAn5uRNCtZdPPhDv+Az8E=;
        b=XNv1WyHa6KzbGLc0u3c/xui1XtaAkYQJHPfYAYxTo2fsNCIMfSPW2Fj2RYRoiXwyQfr7Hs
        xB0JH2sPXbGEq9XKc0OOqQLSBdMQtYb5nQb4aC/zUD1vxvGH8SSpiUiyqjwREvnB/zE7mu
        ijRFmXAkNh3PTi3E5EMss36zeXp3l8o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-uucXm7f8Nme8dccQphk9QQ-1; Wed, 24 Jun 2020 15:24:25 -0400
X-MC-Unique: uucXm7f8Nme8dccQphk9QQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A65A804003;
        Wed, 24 Jun 2020 19:24:23 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-113-18.ams2.redhat.com [10.36.113.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 485145C1BB;
        Wed, 24 Jun 2020 19:24:17 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] glibc: Perform rseq registration at C startup and thread creation (v21)
References: <20200622180803.1449-1-mathieu.desnoyers@efficios.com>
        <20200622180803.1449-2-mathieu.desnoyers@efficios.com>
        <87d05obl4w.fsf@oldenburg2.str.redhat.com>
        <1158112159.11628.1593025203438.JavaMail.zimbra@efficios.com>
        <87r1u48eix.fsf@oldenburg2.str.redhat.com>
        <1248023868.11643.1593026198678.JavaMail.zimbra@efficios.com>
Date:   Wed, 24 Jun 2020 21:24:15 +0200
In-Reply-To: <1248023868.11643.1593026198678.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 24 Jun 2020 15:16:38 -0400
        (EDT)")
Message-ID: <87mu4s8dy8.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

>> I think we should keep things simple on the glibc side for now and do
>> this changes to the kernel headers first.
>
> Just to be sure I understand what you mean by "keep things simple", do you
> recommend removing the following lines completely for now from sys/rseq.h ?
>
> /* Ensure the compiler supports rseq_align.  */
> __rseq_static_assert (__rseq_alignof (struct rseq_cs) >= 32, "alignment");
> __rseq_static_assert (__rseq_alignof (struct rseq) >= 32, "alignment");

Yes, that's what I meant.

Thanks,
Florian

