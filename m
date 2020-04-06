Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EC19F5CD
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 14:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgDFM3y (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 08:29:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59947 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgDFM3y (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 08:29:54 -0400
Received: from mail-qk1-f200.google.com ([209.85.222.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <gpiccoli@canonical.com>)
        id 1jLQsx-00060j-JA
        for linux-api@vger.kernel.org; Mon, 06 Apr 2020 12:29:51 +0000
Received: by mail-qk1-f200.google.com with SMTP id e13so319433qkn.15
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 05:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OF5+/9Hx0SVxloqW+AsVqfRADYJTfKE7xEAXHE0ATtQ=;
        b=I5j6N0OzGaFKyBQeFPKKaPSYhYXeE8RKp8MBj3MS7cHq2J2E6WyU5K9Ub4JKBAWLtv
         8bbuFhcraAMMNU7gJprQV2TmbcZ0KET/mbK1lgKmHdm89vjhIu9ofFkzoysKUbFpBZI/
         mPC+06T/h3a3JzJeZQU7Xku4MBQHbALI4DL5hNL7ITBOxNfTc6MwlXyPwfVXnCzpRrsy
         5XGXJX17oYSzJyr6AAG4Uut2+cicgFEn5IfVAgdXkm7FoYP8QhwrAxzB7OfX8MUXTylY
         ZcB/ZCMYbwvyZwGpweUNDGxlbI+wejAh0nN8skC4CNN5Xe1f6rKPzkrblXYIhAtvdkzQ
         +KjQ==
X-Gm-Message-State: AGi0Pubd8bzLJ4RbDmm1+g8qQfYseISAgCwOyLRZCfAg1Vn9KetSZuU0
        lLXGwNBOxq/W7RzYz7/rHjD9OOIR2mRtx85PdJIAC8jdzBICbS+ewkRP4hkqIxMcaZ9Ch0V9jfq
        wCXWLhxo/Inhx4v8gqfB1SJf27BDw+ASA+jqLnw==
X-Received: by 2002:a05:6214:b8e:: with SMTP id fe14mr20926382qvb.44.1586176190789;
        Mon, 06 Apr 2020 05:29:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFzhFbMp0Mc44zEb42FJlJTJPveQx3ILgrcP5rWAHivUCkkwOrdkiZvWqvKm7FEtjLJMVxzA==
X-Received: by 2002:a05:6214:b8e:: with SMTP id fe14mr20926359qvb.44.1586176190595;
        Mon, 06 Apr 2020 05:29:50 -0700 (PDT)
Received: from [192.168.1.75] (201-27-34-233.dsl.telesp.net.br. [201.27.34.233])
        by smtp.gmail.com with ESMTPSA id q15sm15131081qtj.83.2020.04.06.05.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 05:29:49 -0700 (PDT)
Subject: Re: [PATCH V3] panic: Add sysctl to dump all CPUs backtraces on oops
 event
To:     akpm@linux-foundation.org, keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, mcgrof@kernel.org, yzaikin@google.com,
        tglx@linutronix.de, vbabka@suse.cz, rdunlap@infradead.org,
        willy@infradead.org, kernel@gpiccoli.net
References: <20200327224116.21030-1-gpiccoli@canonical.com>
From:   "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gpiccoli@canonical.com; prefer-encrypt=mutual; keydata=
 mQENBFpVBxcBCADPNKmu2iNKLepiv8+Ssx7+fVR8lrL7cvakMNFPXsXk+f0Bgq9NazNKWJIn
 Qxpa1iEWTZcLS8ikjatHMECJJqWlt2YcjU5MGbH1mZh+bT3RxrJRhxONz5e5YILyNp7jX+Vh
 30rhj3J0vdrlIhPS8/bAt5tvTb3ceWEic9mWZMsosPavsKVcLIO6iZFlzXVu2WJ9cov8eQM/
 irIgzvmFEcRyiQ4K+XUhuA0ccGwgvoJv4/GWVPJFHfMX9+dat0Ev8HQEbN/mko/bUS4Wprdv
 7HR5tP9efSLucnsVzay0O6niZ61e5c97oUa9bdqHyApkCnGgKCpg7OZqLMM9Y3EcdMIJABEB
 AAG0LUd1aWxoZXJtZSBHLiBQaWNjb2xpIDxncGljY29saUBjYW5vbmljYWwuY29tPokBNwQT
 AQgAIQUCWmClvQIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRDOR5EF9K/7Gza3B/9d
 5yczvEwvlh6ksYq+juyuElLvNwMFuyMPsvMfP38UslU8S3lf+ETukN1S8XVdeq9yscwtsRW/
 4YoUwHinJGRovqy8gFlm3SAtjfdqysgJqUJwBmOtcsHkmvFXJmPPGVoH9rMCUr9s6VDPox8f
 q2W5M7XE9YpsfchS/0fMn+DenhQpV3W6pbLtuDvH/81GKrhxO8whSEkByZbbc+mqRhUSTdN3
 iMpRL0sULKPVYbVMbQEAnfJJ1LDkPqlTikAgt3peP7AaSpGs1e3pFzSEEW1VD2jIUmmDku0D
 LmTHRl4t9KpbU/H2/OPZkrm7809QovJGRAxjLLPcYOAP7DUeltveuQENBFpVBxcBCADbxD6J
 aNw/KgiSsbx5Sv8nNqO1ObTjhDR1wJw+02Bar9DGuFvx5/qs3ArSZkl8qX0X9Vhptk8rYnkn
 pfcrtPBYLoux8zmrGPA5vRgK2ItvSc0WN31YR/6nqnMfeC4CumFa/yLl26uzHJa5RYYQ47jg
 kZPehpc7IqEQ5IKy6cCKjgAkuvM1rDP1kWQ9noVhTUFr2SYVTT/WBHqUWorjhu57/OREo+Tl
 nxI1KrnmW0DbF52tYoHLt85dK10HQrV35OEFXuz0QPSNrYJT0CZHpUprkUxrupDgkM+2F5LI
 bIcaIQ4uDMWRyHpDbczQtmTke0x41AeIND3GUc+PQ4hWGp9XABEBAAGJAR8EGAEIAAkFAlpV
 BxcCGwwACgkQzkeRBfSv+xv1wwgAj39/45O3eHN5pK0XMyiRF4ihH9p1+8JVfBoSQw7AJ6oU
 1Hoa+sZnlag/l2GTjC8dfEGNoZd3aRxqfkTrpu2TcfT6jIAsxGjnu+fUCoRNZzmjvRziw3T8
 egSPz+GbNXrTXB8g/nc9mqHPPprOiVHDSK8aGoBqkQAPZDjUtRwVx112wtaQwArT2+bDbb/Y
 Yh6gTrYoRYHo6FuQl5YsHop/fmTahpTx11IMjuh6IJQ+lvdpdfYJ6hmAZ9kiVszDF6pGFVkY
 kHWtnE2Aa5qkxnA2HoFpqFifNWn5TyvJFpyqwVhVI8XYtXyVHub/WbXLWQwSJA4OHmqU8gDl
 X18zwLgdiQ==
Message-ID: <2eda78ca-6a0e-7a70-d800-13fbe0038ebb@canonical.com>
Date:   Mon, 6 Apr 2020 09:29:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200327224116.21030-1-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrew / Kees, sorry for the ping.
Is there anything else missing in this patch? What are the necessary
steps to get it merged?

Thanks in advance,


Guilherme
