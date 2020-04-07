Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2801A0D59
	for <lists+linux-api@lfdr.de>; Tue,  7 Apr 2020 14:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgDGMND (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 7 Apr 2020 08:13:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43422 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgDGMNC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 7 Apr 2020 08:13:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id w15so3580936wrv.10;
        Tue, 07 Apr 2020 05:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kjoqV17x3dtOrhvBE2jQhQ0geEVJAUBKgHhquldIzF0=;
        b=qa3x3Bcak0fRyu62Ts1kbEafh9CRnU34vebcRTJD1Y1xR6tJ1kfJPwiMOocEfOxprY
         QOyBhzM1r4qoSQzt2ycJZhxlFi2V9FoPqxom5TEcVtgrkZovyAKBLNe4ajAAlM8B2Wz9
         bV+XeN0hMVucbeykMZFE055pmFdpoCPlhoSiPLICqtcJX3GcfYFmZMZrh1aliVYE6gkS
         hhknhX6pCGAEGW5kv3R32irlPYApavaGwcXHvJ14dnVIkchZfCVqh4LMkRhE2M3GVSGI
         MQjfRvxQ/1kaNgc/57shFwYMBPjUeb+2fmFU8o7yv794B6958aRcEbb27QbGtRXSfW7H
         kpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kjoqV17x3dtOrhvBE2jQhQ0geEVJAUBKgHhquldIzF0=;
        b=VqLpoiPS3TW/e5++UN3BQL1J3CDL7QOSoTtgSsk2QpYp3maT9Ff7BjqkXEg0vSk337
         O3Urzs7infCtQeUB205RQIkfd6GSe2qa74O7+K2dJ2INnDqY3JAHbGGfaZPKkJO5VqFL
         emdEjR+JTW9ck4++NUlZuUZcZh9jdEH8b+7AIa3rzCml8pL0lBFRJfRv03M4dUX4CNZj
         qYxqpQOc4/5JzVSUBwmGSSzJM2nEgMGMZW1cqW1tk1Ed6rx+VMUAiyHnZ61BK82/cL6q
         7ke2tRWANlBT4NAFMIV5NpGeNqmrH3+XS4eB3fc3xEk/QO8grTaq2ak8XOpefk1rYNOD
         C4/w==
X-Gm-Message-State: AGi0PuanfS2DmD2TdSJFhItFQjJLGp2NXOwNiBgqmfY6j3y6n4zt8Xo3
        cWtA9W/pVxflROTAegSi4YdEh7YN
X-Google-Smtp-Source: APiQypJ0dtmuuG9mYOOGtQb9kTWK6vCH1Ei8Yat5iVViZAcJ4V21njOHjgv37CRcrmZcv5FWYo1ZsQ==
X-Received: by 2002:adf:aac5:: with SMTP id i5mr2298773wrc.285.1586261580416;
        Tue, 07 Apr 2020 05:13:00 -0700 (PDT)
Received: from ?IPv6:2001:a61:2482:101:3351:6160:8173:cc31? ([2001:a61:2482:101:3351:6160:8173:cc31])
        by smtp.gmail.com with ESMTPSA id x8sm4233605wrn.27.2020.04.07.05.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 05:12:59 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Containers <containers@lists.linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: RFC: time_namespaces(7) manual page
To:     Dmitry Safonov <dima@arista.com>, Andrei Vagin <avagin@openvz.org>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
 <a74763df-6523-2103-b687-27cae3a433fc@arista.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <24672aab-7e71-bf0d-2a52-0678b3cd5620@gmail.com>
Date:   Tue, 7 Apr 2020 14:12:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <a74763df-6523-2103-b687-27cae3a433fc@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/6/20 1:50 PM, Dmitry Safonov wrote:
> Hi Michael,
> 
> On 4/4/20 12:08 PM, Michael Kerrisk (man-pages) wrote:
>> Hello Dmitry, Andrei, et al.
>>
>> I have written a manual page to document time namespaces.
>> Could you please take a look and let me know of any
>> corrections, improvements, etc.
> 
> Thanks a lot for the man page. It looks good to me.
> Maybe Andrei will find some nits, but I don't have any in mind.

Thanks for checking it, Dima!




-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
