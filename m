Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2339049A
	for <lists+linux-api@lfdr.de>; Fri, 16 Aug 2019 17:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHPPXK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 16 Aug 2019 11:23:10 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46047 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbfHPPXK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Aug 2019 11:23:10 -0400
Received: by mail-pl1-f196.google.com with SMTP id y8so2572640plr.12
        for <linux-api@vger.kernel.org>; Fri, 16 Aug 2019 08:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFti+zNvQA9kVdJ6DDIY7OYNLBs2lOCWDTzkw0nUD80=;
        b=Z8gw3qQ3EpRbvSZUh3R7hzjHnSqvlw8ciyVqmAb9t6XxEgQs0K4NpZJClx89yaoZXu
         mzEPlJlD3PSsolEmNy6TBzAnvNH+ZRT+TQvnKvr7c20tXMirOH71tuT+ajOlCIpnf02u
         VbInOo9LcyZoEEdbVObT/3tNn8gYhCK7Z9iZHirO5k9G7fumthTedlDkRjsEiUSgGa9b
         F4xIzVeKmu2aw8Yx2dB5sCOUSwwPVEpNK7uuqB02oKMWvMjui42bauIFQGvtSL8ACFck
         hQpcAJATsvmf70iqSskxJQeNtejyWelcHAYIvJKeFCbKt8woPeVBKHuLOASwBwy9lCOP
         Mz7A==
X-Gm-Message-State: APjAAAU/9rWfE75dlR2qxH02Wu3SJ3t2zSEmAdctSs2niSpLU4Fs55m2
        W7lxQtchIzTiYM3hre+8GgKKBg==
X-Google-Smtp-Source: APXvYqzsTSLEm9rLzgU+7dBp85epFTFwtYeSb3u6V0/FZQr5/N4HdqlCrBqxgRiqpiiNW0OWSpsxFA==
X-Received: by 2002:a17:902:b591:: with SMTP id a17mr10064468pls.189.1565968989996;
        Fri, 16 Aug 2019 08:23:09 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id o24sm14125178pfp.135.2019.08.16.08.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2019 08:23:09 -0700 (PDT)
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-24-dima@arista.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <b719199a-ed91-610b-38bc-015a0749f600@kernel.org>
Date:   Fri, 16 Aug 2019 08:23:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815163836.2927-24-dima@arista.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 8/15/19 9:38 AM, Dmitry Safonov wrote:
> As it has been discussed on timens RFC, adding a new conditional branch
> `if (inside_time_ns)` on VDSO for all processes is undesirable.
> It will add a penalty for everybody as branch predictor may mispredict
> the jump. Also there are instruction cache lines wasted on cmp/jmp.
> 
> Those effects of introducing time namespace are very much unwanted
> having in mind how much work have been spent on micro-optimisation
> vdso code.
> 
> The propose is to allocate a second vdso code with dynamically
> patched out (disabled by static_branch) timens code on boot time.
> 
> Allocate another vdso and copy original code.


I'm unconvinced that any of this magic is wise.  I think you should make 
a special timens vvar page that causes the normal fastpath to fail 
(using a special vclock mode, a special seq value, or a special "last" 
value) and then make the failure path detect that timens is in use and 
use the timens path.


--Andy
