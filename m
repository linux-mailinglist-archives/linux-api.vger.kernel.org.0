Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C363785A67
	for <lists+linux-api@lfdr.de>; Thu,  8 Aug 2019 08:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfHHGSX (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 8 Aug 2019 02:18:23 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34688 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbfHHGSX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Aug 2019 02:18:23 -0400
Received: by mail-pg1-f193.google.com with SMTP id n9so37257840pgc.1;
        Wed, 07 Aug 2019 23:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+r07c/lyTLQL7Cb4AGcka/LdpqVJd36eUIffcM8hTEI=;
        b=sLFf/+X5t4mu5egKSTcDzlZSPbcJL6iZZvb/C1hbneK3GQewRY0r6dePKSVxXYBtcc
         Bjc9990Yfki8ZU+cvc6XgC2m3JTSUPtOitKLi1eDo6+M/XU/hkBu5hH8teK2OHRv/Ayw
         gccl4gGPs9zP8EdniqWEXahGiou4cVqazBRovMUEkf5QfvPI6gD5hkz4BAnSdo0yg973
         U9NZE6qpaoZ6qodH2NbpPHjSiM4xYrFAB7myZhH4+tuvVVwDTyyAEMxOJ5wFzePDtJ1H
         1UxHS+mvTHNt5M9YBFwSFXcxu9LeunlN9/KCoWzsFoPWmGJ6uG9gbQ0YIaSkBHJjcx6r
         FY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+r07c/lyTLQL7Cb4AGcka/LdpqVJd36eUIffcM8hTEI=;
        b=XGPLVBODUayNOy15kxTzB4z+AeR5gQ7nxZbPzaQGw1jEX/97N3RAlUKjKcbqgy4zdE
         zBQlBbZmoaVRXJP5WRr+pvYUtD0FA5M/LCtB2RbD4LZ9CTlQZsitlH90DIB3mITwMW8E
         GLqxD64b92io840e7iNATsTfU5oyEchqNdZFHpNYZUbyfsIc72BXS4Y4M+BED69ffZRe
         8nTtFT+O+Mod/HKcM+GGsq5lppne+Bam7qbi7yMlJqJB5ASQ1IakLzdxo+2lo9B/L+zb
         S5zo3W2p/jsTPLB01gVLVgcQDCd+DU+eYHW+USCLGpPfpF4EM/SGW6Aztath2VPqGhEI
         YMmw==
X-Gm-Message-State: APjAAAUzyuVrwxWpnFuOzZcr8/NtyF0Ba+wfhBqMtZvrQk0EB/8AIw0w
        qalgZSOD27ewcgBI4NCyWwE=
X-Google-Smtp-Source: APXvYqyI6sQQOLvaUkbq+xcUhJltUxl7laFmc7PhkK8VyXwXItFdpiaQtI0VtgaEzPhH6BddDmMMCw==
X-Received: by 2002:aa7:9118:: with SMTP id 24mr13168559pfh.56.1565245102667;
        Wed, 07 Aug 2019 23:18:22 -0700 (PDT)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id u7sm84239482pgr.94.2019.08.07.23.18.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 07 Aug 2019 23:18:21 -0700 (PDT)
Date:   Wed, 7 Aug 2019 23:18:19 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Adrian Reber <adrian@lisas.de>,
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
Subject: Re: [PATCHv5 06/37] alarmtimer: Provide get_timespec() callback
Message-ID: <20190808061819.GA20004@gmail.com>
References: <20190729215758.28405-1-dima@arista.com>
 <20190729215758.28405-7-dima@arista.com>
 <alpine.DEB.2.21.1908070803030.24014@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1908070803030.24014@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 07, 2019 at 08:04:10AM +0200, Thomas Gleixner wrote:
> On Mon, 29 Jul 2019, Dmitry Safonov wrote:
> >  /**
> > @@ -869,8 +871,10 @@ static int __init alarmtimer_init(void)
> >  	/* Initialize alarm bases */
> >  	alarm_bases[ALARM_REALTIME].base_clockid = CLOCK_REALTIME;
> >  	alarm_bases[ALARM_REALTIME].get_ktime = &ktime_get_real;
> > +	alarm_bases[ALARM_REALTIME].get_timespec = posix_get_timespec,
> 
> That's just wrong:
> 
> >  /*
> >   * Get monotonic time for posix timers
> >   */
> > -static int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
> > +int posix_get_timespec(clockid_t which_clock, struct timespec64 *tp)
> >  {
> >  	ktime_get_ts64(tp);
> >  	return 0;
> 
> Using a proper function name would have avoided this.

You are right. Will fix. Thanks!
> 
