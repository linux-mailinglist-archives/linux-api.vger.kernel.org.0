Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D07A041F248
	for <lists+linux-api@lfdr.de>; Fri,  1 Oct 2021 18:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhJAQns (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 1 Oct 2021 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbhJAQns (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 1 Oct 2021 12:43:48 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B041CC06177D
        for <linux-api@vger.kernel.org>; Fri,  1 Oct 2021 09:42:03 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id q125so9702291qkd.12
        for <linux-api@vger.kernel.org>; Fri, 01 Oct 2021 09:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aQbL8pXIXocxX9H8b/2nNpVZyCyOOEJ+2eX3f4bQsb0=;
        b=wXbQCGjvp4GLHV24dvNcEoftO+b+jxKTmz0SX5x2HR0+WKCJvkioVyd5rDUb2pCsyj
         o4MwxX88vRap3XoIMPH26Rln/IMU3v7eS9oXh7nMXv+ICLXwXcGBr6pwdAR2E1rH+e9G
         KNiwnEpz/fBuGfOjg9/YJkFPWP0jIasbrHIi5xoe9Jmc2rwoK0LDzR/wU1wjZbeFmvdD
         YEhrospe7J6JtzCADzrRF55UOLO4nVmGg2KvlI4Zwe+SSleJ/yccWHSdHTqccQETU7z8
         JuQIl058Sfvctk3JRr/BoFuVNjJ4FsVaTDrdfRW23LqaJ1v9W9MoKhc5ea1v1Qa+zBz4
         WCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aQbL8pXIXocxX9H8b/2nNpVZyCyOOEJ+2eX3f4bQsb0=;
        b=CHNEJKwLE8QOzLTo9lzcf7sC4ScrXrX+JIsh5bO6dpgUZ1HPW6GYCM6AuD6i8yTsHd
         qsnEz0QNcHTi+skKA2ZUqLWaNhb8VIinVB8JPK/KTZgCm6uvuyIdqWGK9X85U3tRxYlz
         M9w0pS/rdgtp7lIDKJyis+DKiITgHczQ3kOsqCNB8yUs/QMGfc328o/6JnNNiEQWVfyr
         de/1EYQdDl1k+PbZJqA7OV4Jskzz7X/aIreL4J3MqFQ/MY8l/g4Aa78OFmetpjYHA8tX
         OJezdIZmpC3WnNYwrdJsR6Ni42qmzAkLThVpdfCSAAII4dov9R/PJjaFVqTSnveaQTVF
         kLew==
X-Gm-Message-State: AOAM5316/f/NFVudny7VQ9423hrpI/kFirpui4KE6GDvO6u/mjzmNAAj
        lYh/PcgRJebKc8Mi0O428f7pkw==
X-Google-Smtp-Source: ABdhPJxEISaAeFeyVBnUq/DuWLEI7heMQCiSZdmm/c7At99cOYDg6yzkNykzMscChFIJiV2TCPFeTA==
X-Received: by 2002:ae9:eb58:: with SMTP id b85mr10034928qkg.323.1633106522896;
        Fri, 01 Oct 2021 09:42:02 -0700 (PDT)
Received: from [192.168.3.43] (c-67-174-166-185.hsd1.ga.comcast.net. [67.174.166.185])
        by smtp.gmail.com with ESMTPSA id p12sm3298438qkj.54.2021.10.01.09.42.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:42:02 -0700 (PDT)
Subject: Re: [RFC PATCH 00/13] x86 User Interrupts support
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <christian@brauner.io>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Raj Ashok <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Zeng Guang <guang.zeng@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Randy E Witt <randy.e.witt@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, qemu-devel@nongnu.org
References: <20210913200132.3396598-1-sohil.mehta@intel.com>
 <456bf9cf-87b8-4c3d-ac0c-7e392bcf26de@www.fastmail.com>
 <YVXmGTo5Uzp44QQq@stefanha-x1.localdomain>
 <778d40fe-ad8e-fd7c-4caa-499910bb0925@intel.com>
 <YVc47ohb4nxrBO5h@stefanha-x1.localdomain>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3abdadab-9b7e-7cc0-5ec5-17fa385ce7d4@linaro.org>
Date:   Fri, 1 Oct 2021 12:41:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YVc47ohb4nxrBO5h@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 10/1/21 12:35 PM, Stefan Hajnoczi wrote:
> QEMU's TCG threads execute translated code. There are events that
> require interrupting these threads. Today a check is performed at the
> start of every translated block. Most of the time the check is false and
> it's a waste of CPU.
> 
> User interrupts can eliminate the need for checks by interrupting TCG
> threads when events occur.

We used to use interrupts, and stopped because we need to wait until the guest is in a 
stable state.  The guest is always in a stable state at the beginning of each TB.

See 378df4b2375.


r~
