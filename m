Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4441E14A5E0
	for <lists+linux-api@lfdr.de>; Mon, 27 Jan 2020 15:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbgA0OTh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 Jan 2020 09:19:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38219 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgA0OTh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 27 Jan 2020 09:19:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so2284662wmj.3;
        Mon, 27 Jan 2020 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uCAdJLVoj2sUq92e/C8T9Kl39r5x3+zdQIfnr0K+8yA=;
        b=ssqAzss3O9NyAFx6NTF8QNCuJrNS/W0OasPeu4LwLXZyw1FDiZsMn1EAckIqWT+2bn
         E8R8XGLdSjZsirJf89WdkUazx+Gb4i5K82rv2neIpwL9eGom2wDoMmsGwjEB4ELsOQXv
         J0IlvcG2rd/PTM3G4h0+CVEHbweJVZPVYdnND/4BAQoYKOHE+jRNEpWnBJteYnbnXFly
         YFUN+ZZSw23XHAq/TpQZfLCuCwH2zbHZfU7egpSLCLU85J1v9z5cvSuPu2kdbBIdtJeO
         u9vpRS89nnp+0ie2j+N4d73CCx2viKC/SGFquW12trAgUtfK3c8R3AF5vsdwrZr7EZVU
         VxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uCAdJLVoj2sUq92e/C8T9Kl39r5x3+zdQIfnr0K+8yA=;
        b=ZlatLrrfxZceoy0lrQS1tIx57QTO31d+6jNxtG8nMvGClIgxXgkxtJrp13lh41ZCeP
         I+HnIwvNWg8coAGJMEVlKqz66rHng78hgatbA5zR+nVgtXUR4dMdyF2cZUt7VrakIkJZ
         Uo635e2EQJPWsWTMAGYriyy7NCZF34Cy7xltHY1mzKlSt9Eni91fS1JHqNeQmmhzevN/
         SGwXGuH+Mtj5U4tnoTGzrhC5xjxXhPgzU/qgg94Ux2vv74cVoXH7v5BoYv0Bm6d+/sAC
         6ncrjglxcFXZ9JxvLlnYcF9xpK4Tq8PuzTnGI9TOUn0mCluKmUqePyV27/ULQfUf6GrO
         c8Tg==
X-Gm-Message-State: APjAAAWIrvwXANiT38XKSh7p7wJGA11eBIgbnPkrgxk266obZVL7uZGN
        UMv0IlimnKkn4obzlRtoR8Y=
X-Google-Smtp-Source: APXvYqxZYDhx+pQPoRugT+5txziPdge9/7sxEo3a0e0ANlKSdRIEc6rJbMNCuJQwbQnAIF9h0P+L2A==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr14757024wme.83.1580134774786;
        Mon, 27 Jan 2020 06:19:34 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g25sm28908061wmh.3.2020.01.27.06.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 06:19:34 -0800 (PST)
Subject: Re: [PATCHv8 03/34] ns: Introduce Time Namespace
To:     Dmitry Vyukov <dvyukov@google.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrei Vagin <avagin@openvz.org>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        Linux API <linux-api@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrei Vagin <avagin@gmail.com>
References: <20191112012724.250792-1-dima@arista.com>
 <20191112012724.250792-4-dima@arista.com>
 <CACT4Y+b70bRRS2XD3yxhBoy4E-LFy_K3wMrjeuPmiEvaPe_c2Q@mail.gmail.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <c0a13024-5f56-133a-61f1-c4185f5ac210@gmail.com>
Date:   Mon, 27 Jan 2020 14:19:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b70bRRS2XD3yxhBoy4E-LFy_K3wMrjeuPmiEvaPe_c2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Dmitry,

On 1/27/20 2:12 PM, Dmitry Vyukov wrote:
> On Tue, Nov 12, 2019 at 2:30 AM Dmitry Safonov <dima@arista.com> wrote:
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3f7f8cdbc471..037abc28c414 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13172,6 +13172,8 @@ T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
>>  S:     Maintained
>>  F:     fs/timerfd.c
>>  F:     include/linux/timer*
>> +F:     include/linux/time_namespace.h
>> +F:     kernel/time_namespace.c
> 
> Is it supposed to be kernel/time/namespace.c?

Yes, thanks for catching this.
I'll send a fixup shortly.

Thanks,
          Dmitry
