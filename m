Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F092F3690
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 19:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbfKGSFX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 7 Nov 2019 13:05:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36932 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbfKGSFX (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 7 Nov 2019 13:05:23 -0500
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EC9293688E
        for <linux-api@vger.kernel.org>; Thu,  7 Nov 2019 18:05:22 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id u23so3499893qtb.22
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 10:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MAfLJ3+jySZ+Gp3GxsVTFFw/02bZgFPHyvYuRbXCGGQ=;
        b=k2VYtCnYO4CGRaVwCJDwvTCzwVDN9UBELx76EHx1MsUcVaE/2C95FMzivV1rTToGJP
         WN/yZGvEc7B9W2UtqekLgio3z/D/hTlmi3HRKt4MmzzyjKzfPhLZqWhDrk3SI++O5gg+
         cI4ac19VgJgiDCpWpQhFEBXAUKnSBeuabjsqcvQ10FEtRQijx9djjFQ9vOhmnBqp5DV4
         CwfXwTD2kaCvRiRauq0d1KqlmNLtihw8B9wabHvjLwN+aQQ6VLHvOHDKXiADLL2A/TF+
         +ZxUdLraXKPAiA60PAiC6urhTuV9nZT6gOu7oUErlQEPv7p+9q4ITQPbbJgsi/0C/FZJ
         CwpQ==
X-Gm-Message-State: APjAAAUDQ7vDYaByxXMGW0z5jYhBnHUgJftc9hVh6wsWa0MQ+mSDM42M
        4l8PvVOCIy+gVb7kcTZypZ2uXWIJW6SltHvHTkHy38C/GqL7xwQFGASW972P2GlEh84vlPWPMqO
        dPqmzqrmAfsLztKhjHYVZ
X-Received: by 2002:a37:4787:: with SMTP id u129mr4017185qka.294.1573149921970;
        Thu, 07 Nov 2019 10:05:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqyW0sZmky6AyqDydUH/y23N/Fip2GARmIxX0a3BmIZpDLM83fQRYnFGKyT8TKwjnrc5II9JBw==
X-Received: by 2002:a37:4787:: with SMTP id u129mr4017153qka.294.1573149921708;
        Thu, 07 Nov 2019 10:05:21 -0800 (PST)
Received: from [192.168.1.4] (135-23-175-75.cpe.pppoe.ca. [135.23.175.75])
        by smtp.gmail.com with ESMTPSA id u1sm1506450qkf.136.2019.11.07.10.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 10:05:20 -0800 (PST)
Subject: Re: Continuing the UAPI split
To:     Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Elichai Turkel <elichai.turkel@gmail.com>,
        Florian Weimer <fweimer@redhat.com>
Cc:     nd <nd@arm.com>, Christian Brauner <christian.brauner@ubuntu.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
 <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
 <87zhh7j38y.fsf@oldenburg2.str.redhat.com>
 <CALN7hCJ_umFqC1L0T19CuiGiGoVwac5807NDw4LiDqSD-VJL=Q@mail.gmail.com>
 <facb4d0d-4e20-41f0-4c01-b210c677c24c@arm.com>
From:   Carlos O'Donell <carlos@redhat.com>
Organization: Red Hat
Message-ID: <086ffddf-553f-453d-a046-4d5e6abead21@redhat.com>
Date:   Thu, 7 Nov 2019 13:05:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <facb4d0d-4e20-41f0-4c01-b210c677c24c@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 11/7/19 11:21 AM, Szabolcs Nagy wrote:
>> Or just giving up and telling users they can't just directly include
>> both libc headers and kernel headers?
> 
> including both libc and linux headers is fragile and
> will break differently across the different linux
> libc implementations.

We saw this all the time working in embedded.

There ends up being a rather tight version coupling that
happens, and that's unfortunate, but a function of cost.

Fixing this so it works in the various cases is costly.

-- 
Cheers,
Carlos.
