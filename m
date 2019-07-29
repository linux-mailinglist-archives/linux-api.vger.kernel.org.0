Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF9F79C6A
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfG2W0l (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:26:41 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33931 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfG2W0l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 18:26:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id w9so43957027wmd.1;
        Mon, 29 Jul 2019 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=12bsGWdtpnmQogV329XxqfXY9WOto2H1cGBjaCwbtPg=;
        b=vHvcfwYW8n5iztzytSxw1WkZq6c/9tauZZMgo1zr34wjMPMImxkuR5fD6Kt+44DWwD
         l58qVL6rzsVHGrHqdiw+hQRgbhepgimAVxVrEIFLGqz9TfmmaJhqQXX2uDnqOdzcl/rl
         Fz0/KsXxqSULUqturLMJKH8sa1IazZ7rzz115S4x9Z2iVvfhcAmQv/dqOrwKKRYcAEiy
         ZZx0EvDqteeB2OAa80CPQuv8b1EsFd38Iv2OP2NvzkLSVKRg9dcK96ADL14U6PJwOzSs
         LmjM/zsjBJXOR9LbtmadiVfkEyEZU9pRY31u41buoW/eV1bHI5INKcac2YbciynHxFLE
         BT1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=12bsGWdtpnmQogV329XxqfXY9WOto2H1cGBjaCwbtPg=;
        b=VOWoBH4vnpo3vWRosxMh4hP8wpYFxmbmiGf0z+UepSC0fkERbOVRvjEAWiduDvpJAM
         uNCCcv6+16yGaqAZu4OF8gtFNFCJykxXspDADW+vTvmmnRffryj/Ooxw0u50AsbfIAFL
         n0If2R4rI6Jz4MI/00UdRWHAzGTzjeor5LH0SNVQ+56U7ZWr7KiKM21h7xjCpTG9Vem1
         06XcmmgoV2X37OrEGlDi2I3MqWHVQWArELCNeqXAfkuMOLVCrJm0mxQnxXekAok1VCsb
         iVMIpHGtJHtv1i8tVWBo15jG6mm5Jz7isDrF3FOqaz6x6L9NRTNa9IDcKGsop8WZzIoG
         h8Og==
X-Gm-Message-State: APjAAAW8bjZVr+HEBp+ggOjxb+jcbaXA9WRDygHCwrXgnj9fNaM2Bm61
        E9JYyaRMIL59+NxB1Ov4hh8=
X-Google-Smtp-Source: APXvYqx79AKG9bxLDGNFLI41PJZw5F2KuJDcNxoJcYhrOhCk5UyQKdsroF7QV4yj7pGIGhBxwYTghg==
X-Received: by 2002:a1c:d108:: with SMTP id i8mr105904356wmg.28.1564439199400;
        Mon, 29 Jul 2019 15:26:39 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 5sm51444443wmg.42.2019.07.29.15.26.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 15:26:38 -0700 (PDT)
Subject: Re: [PATCHv4 02/28] timens: Add timens_offsets
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-3-dima@arista.com>
 <alpine.DEB.2.21.1906141510100.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6e58d0dd-61ae-8566-0f64-badbfe1b20d1@gmail.com>
Date:   Mon, 29 Jul 2019 23:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141510100.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

On 6/14/19 2:11 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> 
>> From: Andrei Vagin <avagin@openvz.org>
>>
>> Introduce offsets for time namespace. They will contain an adjustment
>> needed to convert clocks to/from host's.
>>
>> Allocate one page for each time namespace that will be premapped into
>> userspace among vvar pages.
>> index 000000000000..7d7cb68ea778
>> --- /dev/null
>> +++ b/include/linux/timens_offsets.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_TIME_OFFSETS_H
>> +#define _LINUX_TIME_OFFSETS_H
>> +
>> +struct timens_offsets {
>> +};
> 
> That empty struct which is nowhere used looks odd. Can you move that to the
> patch which actually makes use of it?

I've tried to move the structure into patch
[PATCHv4 05/28] timens: Introduce CLOCK_BOOTTIME offset
but that resulted in an ugly patch.

Then I've tried to make it an opaque type here [to keep
allocation/freeing in one commit], and change to a full structure in the
following CLOCK_BOOTTIME patch, but that wasn't any prettier.

So, we've [with Andrei] addressed your critics but this in v5.

Just to let you know, that we haven't silently ignored your review, but
found that it might be prettier to keep the patch as-is..
I'll move it in v6 if it still makes sense in v5.

Thanks much for your time,
          Dmitry
