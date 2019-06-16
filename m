Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD22B4762C
	for <lists+linux-api@lfdr.de>; Sun, 16 Jun 2019 19:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfFPRsK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 16 Jun 2019 13:48:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37989 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfFPRsJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 16 Jun 2019 13:48:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id d18so7462754wrs.5;
        Sun, 16 Jun 2019 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ThSO14z8dxRAnR6aIr1IzqylMcpg3kvMNycxr8zWOB8=;
        b=NBigtsLAYKz8w5ObUbhc6PIipQufdy30Vvr0GQ/UV81O9F+NLGmUc8u6fuIwdpnoAB
         G4aDrBpfeMks/ZqkxK6FdokI2ldB2jyyLihMKtr791Kjmjus8S23Ns+UtcjPLYVRXwBL
         HNG9BBBCwe/livPQBRUQgszqrJHkJjaMWGSHrCQ8ZWrsxmCNV5yTEXXGweHSrOVYXuY7
         Trdh0OTjbPigEeUD84q93NmHo2yuv3TM9rCxplbivNpVZCZEAyko8bexFzguNKeBzog/
         hwSyZVDtfqp88o4/zErjOc+wnIrNdM+q41BtCEpURFelhsONFXjfvi8GiOAuVNnnMFtK
         XYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ThSO14z8dxRAnR6aIr1IzqylMcpg3kvMNycxr8zWOB8=;
        b=SrzqOoYA/SnxE4HAGlUETCfbeoSsr2senwdlHMgL3Ex8BUEboKyq2opgJzqBk2Oxs/
         qB0FlnuPmaQMV/+4HQAeFTRyPsUa7Ptr7r0TEwxsvpF0dHejJSG8IvimREO/33fx0quL
         r9WCxWmdlDss6R7tVOvH11Oe+Hum6sCA84AyjZBkh399DL0QWfegX0O3/IPqsq4JAO4P
         6r9atJFRaXKqzF9UrYW5SqWY8FvV02IrXpOi692Dy1C3Xr18dPtU3Z+BnGR05ByI/VQ8
         N7NkZx+dgSe66ut0eLKZzUYZAFWElYP2b5CV3I5hxzJHg0YR5nnWh/WntxOUq2GR67K4
         p3zA==
X-Gm-Message-State: APjAAAVr+2xYB6GbHIuz/81V6SDHMVUPAr/GS1BP92INGkXdidGxPlDB
        DX7fLnkcGTaXV4BY5m0ICRU=
X-Google-Smtp-Source: APXvYqzQc5rPXci8lQT7ZDftZOmILFnWTF3t3BzEyBuiY0MGyRb+S996VGdtuRy3WqmVbTwapnsn6Q==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr10677128wrj.51.1560707287860;
        Sun, 16 Jun 2019 10:48:07 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id r4sm19734073wra.96.2019.06.16.10.48.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 10:48:07 -0700 (PDT)
Subject: Re: [PATCHv4 09/28] timens: Shift /proc/uptime
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
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
 <20190612192628.23797-10-dima@arista.com>
 <alpine.DEB.2.21.1906141549560.1722@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <6e675417-37ee-0799-60d9-f85812485842@gmail.com>
Date:   Sun, 16 Jun 2019 18:48:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1906141549560.1722@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 6/14/19 2:50 PM, Thomas Gleixner wrote:
> On Wed, 12 Jun 2019, Dmitry Safonov wrote:
> 
> Again, please use the usual prefix and bolt not everything to
> timens. timens: is the proper prefix for the actual time namespace core
> code.

Yep, will do.

Thanks,
          Dmitry
