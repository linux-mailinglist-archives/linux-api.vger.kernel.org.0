Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D0A1272F8
	for <lists+linux-api@lfdr.de>; Fri, 20 Dec 2019 02:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfLTBos (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Dec 2019 20:44:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39330 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbfLTBos (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Dec 2019 20:44:48 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so6395100ioh.6
        for <linux-api@vger.kernel.org>; Thu, 19 Dec 2019 17:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WEwk0J0BmZw6m3cUGWGohPOAXpqKE+sp6lfv0aKYwSA=;
        b=BCEJG8Pnn7zRX2hVFrKBtfEvBy5FVy2pKsPDlJnMqBSlW3lSfVWwGWGY/XWUBLf7cy
         oZ2UA3E3wReM6h6V3zBhiSta/C/LGav3Lt5hP+XeEzziKgLA3q3V2wxhT7Am0giAvLAC
         nvN8M8xCJ+cSfarEHrjp8Nzb9OlHrjswjB4JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WEwk0J0BmZw6m3cUGWGohPOAXpqKE+sp6lfv0aKYwSA=;
        b=oiUH4fj8QtP8s7/hEeV13lUrNHfh0sV55U1ZR75Dp0985mIazsQR2OgJO6xcUsJEFC
         VMez/oCWH8XHVRjOVvFqLOwkMFxrgYzI09IsjCroZzQoULaP4GVn3niCNd9znE3kEN04
         ChPGfEVDCM7hfkeD/O3s+RE/lmTgjmI1C1VPMPAEoy2O8gNZNOMO6y7WVYb//eHE+0ty
         x+zjz7Otqq9cpw7w3rN8FnjbC99iPet6qlQfgxliNLW3t+4BaiWC2zsTVIRVG+Py2hDc
         pkMKnO2RyeMWb07GgptbtDDEFGCp3iLI8QtJHcibqGTiBfH4zkRlzYLVo6PZgrxWsovb
         fwMg==
X-Gm-Message-State: APjAAAUUtJtBQUPHVh3C1J5Iq1LjweLXyer8fm209uhMZaiOuWr1Tz+C
        xe1wMW7objVTyfyVocoqCy6YMg==
X-Google-Smtp-Source: APXvYqyY3jEL4NiI53AQszGHY3N9Ba44JmALN8fmmooTeX1dfVOwzufANLzAhloEAhLvM+j/gVZNYw==
X-Received: by 2002:a6b:c007:: with SMTP id q7mr7896221iof.58.1576806287673;
        Thu, 19 Dec 2019 17:44:47 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id z15sm3514958ill.20.2019.12.19.17.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2019 17:44:46 -0800 (PST)
Subject: Re: [PATCH for 5.5 1/1] rseq/selftests: Turn off timeout setting
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20191211162857.11354-1-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <f8f04858-ff13-8ec3-0249-8c864fad406a@linuxfoundation.org>
Date:   Thu, 19 Dec 2019 18:44:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191211162857.11354-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 12/11/19 9:28 AM, Mathieu Desnoyers wrote:
> As the rseq selftests can run for a long period of time, disable the
> timeout that the general selftests have.
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Paul Turner <pjt@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>   tools/testing/selftests/rseq/settings | 1 +
>   1 file changed, 1 insertion(+)
>   create mode 100644 tools/testing/selftests/rseq/settings
> 
> diff --git a/tools/testing/selftests/rseq/settings b/tools/testing/selftests/rseq/settings
> new file mode 100644
> index 000000000000..e7b9417537fb
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/settings
> @@ -0,0 +1 @@
> +timeout=0
> 

I am pulling this patch in for Linux 5.5-rc4.

Let me know if you have any objections.

thanks,
-- Shuah
