Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10D6514CF67
	for <lists+linux-api@lfdr.de>; Wed, 29 Jan 2020 18:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgA2RQr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 Jan 2020 12:16:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726647AbgA2RQr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 Jan 2020 12:16:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580318205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5i8mRKm7dmfzydQLNecACgzsC7ykRGuRXnbf9FqfH0=;
        b=cvL1JR8Un+W+ffSF+9W2cpoJqLOvufsXr9slnb8SEv0iAIemqhWRRX67Sh7vm3R4frmrR7
        ITPBp05ZcqcFpmR0yeg5iJGfUYNrMWOecYDu3WJFRMhcCFuzU5c+klNS9A2Oi6CivPBjKK
        KVCEmEujW8RcCT6+85bq/nzNA5tcjpg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-XcH5EQn0MVy7mvYpXEjEKw-1; Wed, 29 Jan 2020 12:16:29 -0500
X-MC-Unique: XcH5EQn0MVy7mvYpXEjEKw-1
Received: by mail-qk1-f200.google.com with SMTP id v2so122690qkf.4
        for <linux-api@vger.kernel.org>; Wed, 29 Jan 2020 09:16:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=M5i8mRKm7dmfzydQLNecACgzsC7ykRGuRXnbf9FqfH0=;
        b=PtI+MjkMvmOQd0m6CLkGtKn4D6Evepe6OeXEy3VLlNejfcHtY9IelWyID2uc7sCxXk
         5Q7scl1UOxEM0oezOAFBA+zNtHOp5i71kjS6A9xzq5UQnahKgersgAzhTbVA6742BAW8
         j/DowdziW9D4JMXs8u0QP+XJKBpCzqv5v4Uc23/8CHyNm8JTwvQ4Rg0whpxxFsa3xtPM
         QVVfpSoTaKp1/2GUfyrombWybarogI9XwlhMH11bOB115+phNSE9fs1tkQF+gkU9Nvau
         1a3KBgFhVlEIZKzn0BPi3srQkrEzgj9jtaI0WxRoA/rbfM3u0RCX4uw3xihSVVR6W0PW
         VtaQ==
X-Gm-Message-State: APjAAAX4nDVlg5L6MFlAJo87b+pDTdz1lqhWgfVGV9h8QxQkLs1zjl9t
        77+oq/m99P4gPBZmwZQriJW54vvM94Q6MXWnnL4dRw3w1kmY/p0LEZ0P8XpfmOPRQh3F6BviYWJ
        7UESJWywz4XnnH5pbZ27c
X-Received: by 2002:aed:3463:: with SMTP id w90mr212208qtd.42.1580318188396;
        Wed, 29 Jan 2020 09:16:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwkX8cUMxuvZFJ1Tw3QGErxjHFehV08dxZzqWRbtYsLGuqNfO2VxYKJ9rzYny1Q56VD+a9z2A==
X-Received: by 2002:aed:3463:: with SMTP id w90mr212190qtd.42.1580318188141;
        Wed, 29 Jan 2020 09:16:28 -0800 (PST)
Received: from [192.168.1.4] (135-23-175-75.cpe.pppoe.ca. [135.23.175.75])
        by smtp.gmail.com with ESMTPSA id n4sm1361026qti.55.2020.01.29.09.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 09:16:26 -0800 (PST)
Subject: Re: Including both linux/time.h and linux/input.h causes failure
To:     Elichai Turkel <elichai.turkel@gmail.com>,
        linux-api@vger.kernel.org
References: <CALN7hC+f+D8xsaJBt+MCXDfk51oHCoQeUVmFydNdkW+_DeqTiw@mail.gmail.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <88ab5e38-254a-430d-67cf-1840b0e51c35@redhat.com>
Date:   Wed, 29 Jan 2020 12:16:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CALN7hC+f+D8xsaJBt+MCXDfk51oHCoQeUVmFydNdkW+_DeqTiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/29/20 10:14 AM, Elichai Turkel wrote:
> Hi,
> The following header: <wrapper.h>:
> ```
> #include <linux/input.h>
> #include <linux/time.h>
> ```
> Will cause the compiler to fail because of redefinition of a lot of
> time related structs, that are declared once in `linux/time.h` and
> then again via `bits/types/struct_timeval.h` which is included through
> `linux/input.h > sys/time.h -> bits/types/struct_timeval.h`
 
This is another header-coordination issue between the kernel and libc.

In this case it's linux/time.h vs. sys/time.h.

"Synchronizing Headers"
https://sourceware.org/glibc/wiki/Synchronizing_Headers
- Just added your case.

It's not immediate clear to me if the UAPI header is clean enough to
use directly in glibc or not, and that's often the simplest way to fix
things.

When you can't just use the kernel header definitions then you have
to work through the conflict and decide if you want to allow both headers
to be potentially included and in which orders to support it.

Why do you need both headers included?

-- 
Cheers,
Carlos.

