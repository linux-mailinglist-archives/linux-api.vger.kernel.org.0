Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9510220E5C
	for <lists+linux-api@lfdr.de>; Wed, 15 Jul 2020 15:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgGONmX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 15 Jul 2020 09:42:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35336 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731932AbgGONmW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 15 Jul 2020 09:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594820541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GmdifN6+jrtO/pnaOcy0zvVaVx7ysyob4B6XZ2mQELI=;
        b=JjKDYqtyq6WElWpmYAOlZjmz2xa2I4QwUDXwnyVx8bf4tX+0fsYHkefserGPZnk+ilSL84
        ntRd+7Yp8UI++50yuj//VfW/mMGEmr6BkwUkZre+b2fk/JkD9H0eS/ZfBLLygdiKjddshS
        JmPVYVzrE2v/yc9J/69cb7Y0bnIC4qs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-wLQPDBG3NQ221ncxurkX1g-1; Wed, 15 Jul 2020 09:42:20 -0400
X-MC-Unique: wLQPDBG3NQ221ncxurkX1g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EFBE100AA22;
        Wed, 15 Jul 2020 13:42:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-112-228.ams2.redhat.com [10.36.112.228])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42F27710D6;
        Wed, 15 Jul 2020 13:42:13 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     carlos <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
        <87mu42bepq.fsf@oldenburg2.str.redhat.com>
        <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
        <87a7028d5u.fsf@oldenburg2.str.redhat.com>
        <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
        <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
        <2053637148.14136.1594818777608.JavaMail.zimbra@efficios.com>
        <87y2nk29rp.fsf@oldenburg2.str.redhat.com>
        <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com>
Date:   Wed, 15 Jul 2020 15:42:11 +0200
In-Reply-To: <882700738.14181.1594819884049.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Wed, 15 Jul 2020 09:31:24 -0400
        (EDT)")
Message-ID: <87mu4028uk.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> So indeed it could be done today without upgrading the toolchains by
> writing custom assembler for each architecture to get the thread's
> struct rseq. AFAIU the ABI to access the thread pointer is fixed for
> each architecture, right ?

Yes, determining the thread pointer and access initial-exec TLS
variables is baked into the ABI.

> How would this allow early-rseq-adopter libraries to interact with
> glibc ?

Under all extension proposals I've seen so far, early adopters are
essentially incompatible with glibc rseq registration.  I don't think
you can have it both ways.

Thanks,
Florian

