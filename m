Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFFA47631
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 19:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfFPRtv (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 13:49:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42602 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFPRtv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 13:49:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id x17so7434299wrl.9;
        Sun, 16 Jun 2019 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/hRwW8vMhzdua2ppKrVssHlA+91ZHXY3leNMzjUdRY4=;
        b=ntz43rBUdHCHjbQbMNk77s+2nvtyM808P08aRWuPumkZQKQBX6uX3qR7c6QxUm+kfY
         S4EgNUI3AZpmQZsUzFnWB4RT0LaH8Laq6DncsDkMX9fm+3bFkj+ZzdhB2lYU/aNpJi6Q
         tkDsXCrXGbev++hsjRGw0l5l9sCVD2tQCDq6NylLb8bCbRMF4u4xmiPyQZ8bkcKhL9yx
         3Q+ki0r9WsqqZe2dk52DqmGmh72uW5896XBCbFJC3NP6YDXchAPXDYyCvEW8DRsNJQfT
         CRjw/s8FNnFFQYUp42lQ3yLiWRPURM1JKRP4ffG2oZPH/ccsRYAY3kGUmK+4Hnsficio
         YaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/hRwW8vMhzdua2ppKrVssHlA+91ZHXY3leNMzjUdRY4=;
        b=tqovYPrMy7TFiV6bhAJAXX+OxqNwuTpUFj9WLyj2v1PL25wpMbU2qKB6BtHU5ggFTk
         j/v+FUEBMMnWbszfagtWryaGzYTfZ+p1H3Oz1vQQaC3/8NIK1KAt3oly73AWYPAzY7o/
         0iQzQK5xJxN3YD7ywKthAd/2bhMOy8D63tl/XUqesptKpTw2Ji60tC7amP3RqCEyviOA
         bLmZZqTD4Y0WwiXCa3sclPZpxNRht+r8FBphBzwfkxEn6upqAkTM8AMhwmV8o9ZlKT5E
         ZA686ZJGV3Bt838a7xvOncnSqYhm58lWLtfOFCw1LoBoUcCGPAphqd2Asaq7CW8jWcXl
         YnxA==
X-Gm-Message-State: APjAAAXbKPtLzWQ9gdcmHlI1RgPcpv3seheTnL9L4Z4xiz3jHjAq/IJq
        W0Whx6LIwlD2z7nTclhQDKXtj1X8nYw=
X-Google-Smtp-Source: APXvYqw8+eaMfU3JJptUOf9opfQ4Ex/advZBsHRVGuf0+Z2384xm0miDcOtIHBye56a10TFgRW3FAw==
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr52857090wrn.160.1560707389051;
        Sun, 16 Jun 2019 10:49:49 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id x8sm10023143wmc.5.2019.06.16.10.49.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:49:48 -0700 (PDT)
Subject: Re: [PATCHv4 15/28] x86/vdso: Add offsets page in vvar
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-16-dima@arista.com>
 <alpine.DEB.2.21.1906141553070.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <cc38a049-aa49-4290-d721-e0adc5d25491@gmail.com>
Date:   Sun, 16 Jun 2019 18:49:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141553070.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/14/19 2:58 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
>>  
>> +#ifdef CONFIG_TIME_NS
>> +notrace static __always_inline void clk_to_ns(clockid_t clk, struct timespec *ts)
>> +{
>> +	struct timens_offsets *timens = (struct timens_offsets *) &timens_page;
>> +	struct timespec64 *offset64;
>> +
>> +	switch (clk) {
>> +	case CLOCK_MONOTONIC:
>> +	case CLOCK_MONOTONIC_COARSE:
>> +	case CLOCK_MONOTONIC_RAW:
>> +		offset64 = &timens->monotonic;
>> +		break;
>> +	case CLOCK_BOOTTIME:
>> +		offset64 = &timens->boottime;
>> +	default:
>> +		return;
>> +	}
>> +
>> +	ts->tv_nsec += offset64->tv_nsec;
>> +	ts->tv_sec += offset64->tv_sec;
>> +	if (ts->tv_nsec >= NSEC_PER_SEC) {
>> +		ts->tv_nsec -= NSEC_PER_SEC;
>> +		ts->tv_sec++;
>> +	}
>> +	if (ts->tv_nsec < 0) {
>> +		ts->tv_nsec += NSEC_PER_SEC;
>> +		ts->tv_sec--;
>> +	}
> 
> I had to think twice why adding the offset (which can be negative) can
> never result in negative time being returned. A comment explaining this
> would be appreciated.
> 
> As I'm planning to merge Vincezos VDSO consolidation into 5.3, can you
> please start to work on top of his series, which should be available as
> final v7 next week hopefully.

Yes, will rebase on the top of his series.

Thanks much,
          Dmitry
