Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE210460D1
	for <lists+linux-api@lfdr.de>; Fri, 14 Jun 2019 16:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfFNOcK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 14 Jun 2019 10:32:10 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37594 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbfFNOcJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 14 Jun 2019 10:32:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id f17so43567wme.2;
        Fri, 14 Jun 2019 07:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Uandy4NW7+01rMpwf5zEVNWMwam/4rt/MkCq7rf9fbU=;
        b=gsCI+Xa7K16dPUnGTbWhHfov4bGDxxNpr6lbmmBH0CtxL1fNS7CjSYDIHZCpMuu2/7
         dRNgwyKkH/RgBIqPrYJQOcgi5wouvhMOXhqrTq21kg96mjAheafNkgUpjp8E3w5q4zut
         8uDqsYVUccOH0ev6k3XvTuQ7K2qJ0pgukegTx6J5MZBbwBcGyzdbYAZFy+6g3uUSNQ/I
         28pmf3yvRpuX2kgMIZIj8ldD8wjNumQcMdzZNXnY/1Qrm+bLZoXqcXf47PDJhUgJ8aSm
         9O1+Ep9d1FCciiTMaJ0Lb2UJrhXwzqbWSiQzSHM2YjVeMZDX/MJMclstv3PGKf7qIJVl
         tI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Uandy4NW7+01rMpwf5zEVNWMwam/4rt/MkCq7rf9fbU=;
        b=p2LKlPXW1PQWrhRfM/Ui+6rRckt0jl/oV6g40SqoM3151hO3OJJGO2qWpwdLod/Vgg
         4+p0h6LzmEd7xqHpmt4M+QPWw/7Drj+PGkbzANSbPry/DFGMe4KR7liTjYw/HZ1yEB+e
         ra+sAyrsAH9VFmMH7YVWllwl/JUIXq8nd4D8LSM0KQVuw9csEB599/JOUUmfKnIvaZJP
         0sUbfvMuFnzHsBuqOlb387CIjneZfISJPmumvn3DdUCQU5Bm7bmzxYiO9LWhxa3xCAQl
         10TV1LPwFhgsKRPftUxtft8laegbiSSdiIsuQrhs408dI/69c0kpJN4ZhNKW57DJp6pV
         iSJA==
X-Gm-Message-State: APjAAAU7t9vehqeGQhZaqKJUfhzfMCzvelOZHAkzblheCL9k9EXefXr3
        YIbqwYDoWQfynSf0+OXlNTs=
X-Google-Smtp-Source: APXvYqxIIZ57El7zbVMXRYSByPPG7UD8/+cPfJ4WNFbpOP3N9Z2/2ax311ze5zcbKoQnCw5faApLvA==
X-Received: by 2002:a1c:eb0a:: with SMTP id j10mr8915277wmh.1.1560522727857;
        Fri, 14 Jun 2019 07:32:07 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id l12sm8479730wrb.81.2019.06.14.07.32.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 07:32:07 -0700 (PDT)
Subject: Re: [PATCHv4 02/28] timens: Add timens_offsets
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
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190612192628.23797-1-dima@arista.com>
 <20190612192628.23797-3-dima@arista.com>
 <alpine.DEB.2.21.1906141510100.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6f647a12-fc3c-8be6-a093-f07ff0c9f114@gmail.com>
Date:   Fri, 14 Jun 2019 15:32:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141510100.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/14/19 2:11 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> 
>> From: Andrei Vagin <avagin@openvz.org>
>>
>> Introduce offsets for time namespace. They will contain an adjustment
>> needed to convert clocks to/from host's.
>>
>> Allocate one page for each time namespace that will be premapped into
>> userspace among vvar pages.
>> index 000000000000..7d7cb68ea778
>> --- /dev/null
>> +++ b/include/linux/timens_offsets.h
>> @@ -0,0 +1,8 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_TIME_OFFSETS_H
>> +#define _LINUX_TIME_OFFSETS_H
>> +
>> +struct timens_offsets {
>> +};
> 
> That empty struct which is nowhere used looks odd. Can you move that to the
> patch which actually makes use of it?

Sure, makes sense.

Thanks,
          Dmitry
