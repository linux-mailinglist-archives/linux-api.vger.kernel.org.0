Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A030F32C685
	for <lists+linux-api@lfdr.de>; Thu,  4 Mar 2021 02:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355447AbhCDA3I (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 3 Mar 2021 19:29:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55792 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237360AbhCCRMW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 3 Mar 2021 12:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614791437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=72AvldDshkpAm4vjL1rTWERNo04lTYkEaJw4N5Ow1KY=;
        b=KwaJjgMdoaO8EQJrjzNTcoUAq2SmwZuMpfzkcmoENN+gTQbSIndpHRrumSXbNuAKFdXf/j
        4RqPuwFWe1utVlap0X7OXuSDX5do5RsqlBYCqzDAd1WHDhjSH01m46Bcqa1EhhF4DpABW+
        TK316qlKshl3JK+F+PKkS5zubAp8xW8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-Vzp06uWgMW-4lLCQSKAZmA-1; Wed, 03 Mar 2021 12:10:33 -0500
X-MC-Unique: Vzp06uWgMW-4lLCQSKAZmA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACB2E100A61D;
        Wed,  3 Mar 2021 17:10:29 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 006F45C5DF;
        Wed,  3 Mar 2021 17:10:21 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Piotr Figiel <figiel@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Oskolkov <posk@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>, emmir <emmir@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2] ptrace: add PTRACE_GET_RSEQ_CONFIGURATION request
References: <20210226135156.1081606-1-figiel@google.com>
        <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
Date:   Wed, 03 Mar 2021 18:10:27 +0100
In-Reply-To: <192824546.8190.1614353555831.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Fri, 26 Feb 2021 10:32:35 -0500
        (EST)")
Message-ID: <87h7lsuprw.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

* Mathieu Desnoyers:

> This way, the configuration structure can be expanded in the future. The
> rseq ABI structure is by definition fixed-size, so there is no point in
> having its size here.
>
> Florian, did I understand your request correctly, or am I missing your
> point ?

No, the idea was that if the kernel ever supports different rseq ABI
sizes on registration (it could as there's a size argument to the rseq
system call), that needs to be communicated to CRIU, so that it restores
with the right size.

I haven't thought about whether it makes sense to make the ptrace
argument struct extensible.

Thanks,
Florian

