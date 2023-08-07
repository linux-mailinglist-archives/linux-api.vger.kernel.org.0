Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D3772E34
	for <lists+linux-api@lfdr.de>; Mon,  7 Aug 2023 20:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjHGSxY (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 7 Aug 2023 14:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjHGSxX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 7 Aug 2023 14:53:23 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B56E10F6
        for <linux-api@vger.kernel.org>; Mon,  7 Aug 2023 11:53:22 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-790b9d7d643so50927239f.1
        for <linux-api@vger.kernel.org>; Mon, 07 Aug 2023 11:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1691434401; x=1692039201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PgsgacHoqG+OZ1TZMpkeUnq5Gq3PMz4u5SxZvCX4REU=;
        b=BxN5dmsR6hmNxzubbYTl/EEjSo0MIoB+q8rG9LVmf/C/2urn8bLuMT0R0XpI4dSuke
         /Q1LqjcOikFiv9oGP9C1xb+m7Yk2ApyUkyVuQTe/Ivq+N/ejPGeJ1YSyowEXkuZVFnjW
         T5a5FEnGfl6AsAqcN6QkEaFPXgiIz79nY4alI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691434401; x=1692039201;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PgsgacHoqG+OZ1TZMpkeUnq5Gq3PMz4u5SxZvCX4REU=;
        b=KCC0E1UIf/PyKPXKu8fH2iu6I80KE2qPGxmBDROisK3Gh3oE4CS4TP3Oxhtgbdm+i6
         ebX+qa9QPcCm8iJUaKNtXVEcmzsB/jU4LkmqBsEw5IJtOww+xvjE0Z178G/MFFbz1c62
         IupXcYBZfwFVqXD73J81CTM7QFBICFiQtg9TNB4WqrQ3q8fByfmYF4WS51p2mzhTVXzl
         O69mptHCNM1rAcJuqRUJaxtdJ+xj+fgTPvSR+HavkeWwuihJmYzIDcYwRA13NLCfOZ+W
         xfsjJTF3gWWLOO10qXmM/jkn9P+2qu18L+ezErVU83jEjZBV0efRlmc76vmpFw5EX8lZ
         rUtA==
X-Gm-Message-State: ABy/qLZdFHD1LtS+zOJDgjSt1tJaU6HTnIkEHUXchxBOIKdAXsrkK8f6
        U8sD8RADhi+gfX4IogFZqGMe1A==
X-Google-Smtp-Source: APBJJlFPHrDX7h9yvv6xMjxm4gNuPs4UYmuHUt7TR5zGbP7iguaVmPk0Fbo2XSpWTWhLnS98QzwGYQ==
X-Received: by 2002:a05:6602:3d5:b0:780:d65c:d78f with SMTP id g21-20020a05660203d500b00780d65cd78fmr40125420iov.2.1691434401310;
        Mon, 07 Aug 2023 11:53:21 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id r7-20020a028807000000b0042b56b57a50sm2541143jai.171.2023.08.07.11.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 11:53:20 -0700 (PDT)
Message-ID: <f0fdf470-f25d-b51f-8a2d-f891ea7b94b1@linuxfoundation.org>
Date:   Mon, 7 Aug 2023 12:53:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] RSEQ selftests updates
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
 <fd64bf35-8e18-8da7-d83c-882fdc60a87d@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <fd64bf35-8e18-8da7-d83c-882fdc60a87d@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/6/23 07:36, Mathieu Desnoyers wrote:
> Hi Peter,
> 
> Can you queue those fixes through your tree ?
> 


Peter, Mathieu,

Doesn't look like this series has been pickedup?

I can take these in for 6.6-rc1 if there are no dependencies
on other trees.

thanks,
-- Shuah



