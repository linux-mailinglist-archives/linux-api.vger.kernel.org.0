Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7228179C33
	for <lists+linux-api@lfdr.de>; Tue, 30 Jul 2019 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfG2WH6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 29 Jul 2019 18:07:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42013 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfG2WH6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 29 Jul 2019 18:07:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so13582180wrr.9;
        Mon, 29 Jul 2019 15:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ALxzhNopH+Mhn0yl7f2Aj425+SEQTfEqix8fAEcqb8g=;
        b=bgSfchK7ozJssLuzSTL7NB2O+UhqdI4MFBKgb5ni0f8lJJyfimQQeWFcpn9xbO46pY
         A/txAKODLhs6iwOYNrmj4z59MjzdNexCXXELfcNOAvl2lTAMBb49tPTMp9fZ3xrWRyAd
         yXJp8VWoqDR2qM7kGtEMSgIJKKbrIsep3OnEC3cOcFIgERtCAyy5fgC1+QrjqsqFbsGf
         WyULjV9tENtZLHWWuDPao//j5KeFRlg7/iB2FKUvA7aUuG2s8btzBR4HyhMozn5g1TsN
         KnQH/4Lqkt0KVdDXBkRvwa/Yf7yg8Mr9z3LgrYGa0kVY1rwzxoP/z6XHlJ76FRhOfrOG
         1fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ALxzhNopH+Mhn0yl7f2Aj425+SEQTfEqix8fAEcqb8g=;
        b=MZ7yWddAGe+B2Znpbb5JgZ2k47h6Uxl2yFsGZ8dNxL3C9dbk9QTO0cAuEDVnPh0f7d
         YtGv/aXKkogx+6PY1C9xvut20ocVUuCqucgAf4/Rmr7kePx1JLbsmoYQqjwwH9xpL8z9
         KTLODr2kMFLIiYVC7sLOuJLenDJKDXSoWk1taF/w3cBM5XRyoQwktPMYj/FeA92GwRep
         iY45AbOgMgSte9PG6ev5YOj8Pbm44THaVOMFHZy+kmVQ9DPAW6Gna5vwt//9jnkyC4ps
         OkAQK/LFBK186CHGQkpqb+f1hBl1H+yos6pgS0I0m2zjq8aRrgVWFH75944lJq6QFduz
         t/YA==
X-Gm-Message-State: APjAAAUnB+iZr2kecjPudmrIbXiStdlPZMFmPHIOkm8v3IpSrEud7Jcz
        n2PYXc+R72A1cwHKkdatdeY=
X-Google-Smtp-Source: APXvYqzjFNi2htEk9WhmVZ2PQgfkTnO69p8V49IH9yfhwiwCnyIdrrqgBDFCT6dU9ob4s5iMAQacbA==
X-Received: by 2002:adf:f050:: with SMTP id t16mr115255555wro.99.1564438075998;
        Mon, 29 Jul 2019 15:07:55 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id 18sm52878888wmg.43.2019.07.29.15.07.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 15:07:54 -0700 (PDT)
Subject: Re: [PATCHv5 00/37] kernel: Introduce Time Namespace
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Reber <adrian@lisas.de>, Andrei Vagin <avagin@openvz.org>,
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
        linux-api@vger.kernel.org, x86@kernel.org,
        Andrei Vagin <avagin@gmail.com>
References: <20190729215758.28405-1-dima@arista.com>
 <20190729215758.28405-39-dima@arista.com>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <4d53ebc7-d5b2-346e-c383-606401d19d3a@gmail.com>
Date:   Mon, 29 Jul 2019 23:07:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190729215758.28405-39-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Sorry for spamming this twice.

I did `git send-email --to linux-kernel@vger.kernel.org /tmp/timens/
--cc 'Dmitry Safonov <0x7f454c46@gmail.com>' /tmp/timens/`

And didn't notice that I've put the same folder ^^ twice :(

Pardon again.

On 7/29/19 10:57 PM, Dmitry Safonov wrote:
> Discussions around time namespace are there for a long time. The first
> attempt to implement it was in 2006 by Jeff Dike. From that time, the
> topic appears on and off in various discussions.
> 
[..]

Thanks,
          Dmitry
