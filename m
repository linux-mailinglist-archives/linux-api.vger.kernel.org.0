Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5A22000F
	for <lists+linux-api@lfdr.de>; Tue, 14 Jul 2020 23:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgGNVbM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 14 Jul 2020 17:31:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40429 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727101AbgGNVbM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 14 Jul 2020 17:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594762270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P2jjMlQNGljDKhczKBKSdNL0F7/+3pAMGrpUsxclRjw=;
        b=KtIQLB/qTL6xS8RZYghG5FskDSWoM0C32N0G7RXDFF53Al+OWDrfS4ImvdOgai9FdYfG3M
        /aMpTHu7qfM4/rtVNYf84OFg8xQA93xw4/sQWdWHN/RZNkWBL3AGcfE5RGMO5N8gkDXGwL
        FD4UHgLJw1A19lYTpbbOU0Mp303PQms=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-2jcc42jiMmSQY8F-eijbwA-1; Tue, 14 Jul 2020 17:30:51 -0400
X-MC-Unique: 2jcc42jiMmSQY8F-eijbwA-1
Received: by mail-qt1-f198.google.com with SMTP id m25so13557930qtk.1
        for <linux-api@vger.kernel.org>; Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=P2jjMlQNGljDKhczKBKSdNL0F7/+3pAMGrpUsxclRjw=;
        b=V6U5EAH0XbVEhmatRAlTzqXi1tVhsCRWcAiFeoacLXo/17L3WMqHuJr9WWYDYmOD60
         M3KM7BACo7F++eKlmtvxA3I1T3/8r2F+BjdWdl7k8sqILbciY8j4qUKbLH/ktG9AeEEy
         ITJvA82CropbPH3HDQow5BW73K07ZJLYZ655gs+vvr08OufK3XB76crEHhLq/qv+g/gh
         UrzJ8/K8lizX2d5fWsKbJsqoQHNRBezN6iVIDlOKK4lwJzPX06sU8dOwOk6OocTbbK6S
         6Pm3poesJYQyzIiOTcB8Kr9iG5Ilpd1uw7o2udfvjYb5wBg/3XFSPpIs9GW+y0ftVEGf
         Zwzw==
X-Gm-Message-State: AOAM533OKkz8WzUbbSGPEPa9YI9ELE3jOwclzd2AMRu1plSwsaMDJttH
        3MGHZ5BjqCdI4uSFh6f7IUfwMDhNcAg1/z46PpCMm2fPgsDBkC44oyi2pnD3jPHjRTxaRfURq5X
        wDSbkRWDXJeM+6qgJTsfy
X-Received: by 2002:a05:6214:b88:: with SMTP id fe8mr6538664qvb.244.1594762251501;
        Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy37EnGkXWH29/is0Rnyzb85M4QGYNcVEtSjI8TXgMm71R1QkncAoCqNse2QQbDKv4E0v71Gg==
X-Received: by 2002:a05:6214:b88:: with SMTP id fe8mr6538645qvb.244.1594762251246;
        Tue, 14 Jul 2020 14:30:51 -0700 (PDT)
Received: from [192.168.1.4] (198-84-170-103.cpe.teksavvy.com. [198.84.170.103])
        by smtp.gmail.com with ESMTPSA id q5sm360934qtf.12.2020.07.14.14.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 14:30:50 -0700 (PDT)
Subject: Re: [RFC PATCH 2/4] rseq: Allow extending struct rseq
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20200714030348.6214-1-mathieu.desnoyers@efficios.com>
 <20200714030348.6214-3-mathieu.desnoyers@efficios.com>
 <87mu42bepq.fsf@oldenburg2.str.redhat.com>
 <131549905.11442.1594731035989.JavaMail.zimbra@efficios.com>
 <87a7028d5u.fsf@oldenburg2.str.redhat.com>
 <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <71f08b3a-56f5-0e0f-53b0-cc680f7e8181@redhat.com>
Date:   Tue, 14 Jul 2020 17:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <2452161.11491.1594732791558.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 7/14/20 9:19 AM, Mathieu Desnoyers wrote:
> Is there an arch-agnostic way to get the thread pointer from user-space code ? That
> would be needed by all rseq critical section implementations.

Yes, and no. We have void *__builtin_thread_pointer (void), but
few architectures implement the builtin so we'd have to go through
a round of compiler updates and backports. All targets know how to
access the thread pointer because the compiler has to generate
IE-mode accesses to the TLS variables.

I have filed an enhancement request:
Bug 96200 - Implement __builtin_thread_pointer() and 
            __builtin_set_thread_pointer() if TLS is supported
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96200

We have glibc internal macro APIs to access the thread pointer,
but I would rather the compiler handle the access since it can
schedule the resulting sequence better.

On some arches setting the therad pointer needs a syscall or
equivalent operation (hppa), and for some arches there is no
fixed register (arm) hence the need for __builtin_thread_pointer()
to force the compiler to place the pointer into a register for
function return.

-- 
Cheers,
Carlos.

