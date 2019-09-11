Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF67B049F
	for <lists+linux-api@lfdr.de>; Wed, 11 Sep 2019 21:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfIKTpT (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Sep 2019 15:45:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59588 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728555AbfIKTpT (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 11 Sep 2019 15:45:19 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 74EBCC04D312
        for <linux-api@vger.kernel.org>; Wed, 11 Sep 2019 19:45:18 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id c7so20827698qkc.2
        for <linux-api@vger.kernel.org>; Wed, 11 Sep 2019 12:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7i0Etx6MLYI/45jnP4DYISG5JeNZkAJR7nS2nO9OITA=;
        b=KlW9fYKm4CXPWTsmwz+UCFbmGnC/cO2o1G2HoCwfpRmWPw+Rw2HrHAqDHNsFqr8aHN
         jvwkLtgnkSu2A8C2v/EXeywMaaj/aM3P6OA/QmKbK2yaCHh4Jp/VuWvh3cAVIx5RbETj
         YJi7y9Dv8ytdTFr4nkpJrWVZtTVr8Z22ZhHR8CbF/ndZfEN7TaHQJIZQiDMmStMI4m4Q
         MOEiZnIN3ORF51LTtKiX6aYm9gFuSMNAdGZ/9bKyyur+Lgp8rzP3NScPuiGW7uF4aXUH
         UuUngvXsCnBa34GTuJ4sGeBNzrax26RTL769qwJbMlxvE0fiV0ZL+GYKgLKv4+Rmv/XW
         uevg==
X-Gm-Message-State: APjAAAXjKEe3X+GpiKAzp57Qd9dDAMDK9YdF8qwNZJwS9MpG4LdU2/qn
        AYUxDhiLfkxrGvr9ju3N8vADXoJw/+/RPRvBcfLxaK1UJmSoVoIoZBBxQU1ZJ0JC5tujJCcWlqc
        ZUzIuvL8KbLlVM6sffbQA
X-Received: by 2002:ac8:688:: with SMTP id f8mr18556205qth.51.1568231117492;
        Wed, 11 Sep 2019 12:45:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymdm0tl7ApS6BtYz0XIfOtihacBxBgcLFt4hc1wZ8x+mNF59Zj9qGHloLFh99pIpLmjDzc6w==
X-Received: by 2002:ac8:688:: with SMTP id f8mr18556165qth.51.1568231117225;
        Wed, 11 Sep 2019 12:45:17 -0700 (PDT)
Received: from [192.168.1.4] (192-0-145-99.cpe.teksavvy.com. [192.0.145.99])
        by smtp.gmail.com with ESMTPSA id t40sm13404749qta.36.2019.09.11.12.45.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2019 12:45:16 -0700 (PDT)
Subject: Re: [PATCH glibc 2.31 1/5] glibc: Perform rseq(2) registration at C
 startup and thread creation (v12)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha@sourceware.org, Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20190807142726.2579-1-mathieu.desnoyers@efficios.com>
 <20190807142726.2579-2-mathieu.desnoyers@efficios.com>
 <8736h2sn8y.fsf@oldenburg2.str.redhat.com>
 <7db64714-3dc5-b322-1edc-736b08ee7d63@redhat.com>
 <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <4a6f6326-ea82-e031-0fe0-7263ed97e797@redhat.com>
Date:   Wed, 11 Sep 2019 15:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87ef0mr6qj.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/11/19 3:08 PM, Florian Weimer wrote:
> * Carlos O'Donell:
> 
>> It would be easier to merge the patch set if it were just an unconditional
>> registration like we do for set_robust_list().
> 
> Note that this depends on the in-tree system call numbers list, which I
> still need to finish according to Joseph's specifications.

Which work is this? Do you have a URL reference to WIP?

> (We have something that should work for us as long as we can get large
> machines from the lab, but I agree that it's not very useful if glibc
> bot-cycle time is roughly one business day.)

Yeah, we have to discuss how to accelerate this.

-- 
Cheers,
Carlos.
