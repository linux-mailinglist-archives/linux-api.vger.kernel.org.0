Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65D739264E
	for <lists+linux-api@lfdr.de>; Mon, 19 Aug 2019 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbfHSOP5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 19 Aug 2019 10:15:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42999 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbfHSOPx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Aug 2019 10:15:53 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so8896896wrq.9;
        Mon, 19 Aug 2019 07:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j87XxrbGpr6xFNUbUB58c7Vd8US5+wAqR7A5uKkJmgg=;
        b=KmRiagLFsj35znGS/BI79vx49mLHVAiBsEdrtjkKEci24tOhfbMClylYAC0o7GqAd5
         QK6P1pWYW3Kf1Sqiyk8KV/sBOcsuDE25ZweOWBh7KWMsfQ2aDbkhMouqvf69mvWWkBdS
         5ZPz5AtAhpTD5UHAfFtCQ5yx1u4XY9JVcm5YDHSETM3Ett9vxJ635AdBqUMn6lzEq4ky
         wtEU9yAYHqWDHLJmZc2W3q0fNudoLIRObTjCRTf2jdfUKAjgMCW/k83+Z26sGnRSMWLD
         CaU7QDAbzUeOOwboCMZzAXbeHyzYJWUqlfD60jdnlSu5Addh5MwgsT9Aex88bo2Cor+M
         ciQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j87XxrbGpr6xFNUbUB58c7Vd8US5+wAqR7A5uKkJmgg=;
        b=jcIKRPUCe+BPA3+9gzTDJ5QLqRs1mtOM10F4faNkLWxk4Ek9s4YzP+Z+qnpwbdPJH7
         mXJjJ5Th3DyuP/WimAq6CXDCdY6wZstA1yJuE/bbentAbjUV5iFoMSG5NEMzUxr/xBoQ
         2bw6t5emJcx69esqgxaAHsvoG7KbHwcLbJxA65S/excQV4vmDoIJX8oH7I6bNf8h+OiU
         MxIPPQC4DG1GD6c2wdbWLv2MvSCRYsvYFBNLKREmxp685WFgxHPBeFhi3PV80Ot8ivhP
         ttBxc6kQ2u/+q7GWoJ++gHRyk67doQbyGTGASDdDWSLP9GofU0VXLQ5wfuxiskpwIx79
         ilcw==
X-Gm-Message-State: APjAAAW9BbUpJ9pSqDL108aNeetRpMSxOmBhJi8+BwIY8IrLSNYH4Nti
        cFskL8bVBjnCapglaCijY2c=
X-Google-Smtp-Source: APXvYqx+FKusv7v6ee8JIs0nlY8aRLz0wUo97s+oVdC9+ytApJ9XpJQO1AY3JozQP4fNeaL0Pt6pAQ==
X-Received: by 2002:a5d:568e:: with SMTP id f14mr27110440wrv.167.1566224150264;
        Mon, 19 Aug 2019 07:15:50 -0700 (PDT)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p10sm12196874wma.8.2019.08.19.07.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:15:49 -0700 (PDT)
Subject: Re: [PATCHv6 23/36] x86/vdso: Allocate timens vdso
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
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
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
References: <20190815163836.2927-1-dima@arista.com>
 <20190815163836.2927-24-dima@arista.com>
 <b719199a-ed91-610b-38bc-015a0749f600@kernel.org>
 <alpine.DEB.2.21.1908162208190.1923@nanos.tec.linutronix.de>
 <483678c7-7687-5445-f09e-e45e9460d559@gmail.com>
 <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de>
From:   Dmitry Safonov <0x7f454c46@gmail.com>
Message-ID: <37f08bfa-0ef8-6df9-e119-e010cdeb9a5a@gmail.com>
Date:   Mon, 19 Aug 2019 15:15:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908171709360.1923@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Thomas,

On 8/18/19 5:21 PM, Thomas Gleixner wrote:
[..]
> I'm happy to review well written stuff which makes progress and takes
> review comments into account or the submitter discusses them for
> resolution.

Thanks again for both your and Andy time!

[..]
> Coming back to Andy's idea. Create your time namespace page as an exact
> copy of the vdso data page. When the page is created do:
> 
>      	 memset(p->vdso_data, 0, sizeof(p->vdso_data));
>      	 p->vdso_data[0].clock_mode = CLOCK_TIMENS;
> 	 p->vdso_data[0].seq = 1;
>  
> 	 /* Store the namespace offsets in basetime */
> 	 p->vdso_data[0].basetime[CLOCK_MONOTONIC].sec = myns->mono_sec;
> 	 p->vdso_data[0].basetime[CLOCK_MONOTONIC].nsec = myns->mono_nsec;
> 	 p->vdso_data[0].basetime[CLOCK_BOOTTIME].sec = myns->boot_sec;
> 	 p->vdso_data[0].basetime[CLOCK_BOOTTIME].nsec = myns->boot_nsec;
> 
>      	 p->vdso_data[1].clock_mode = CLOCK_TIMENS;
> 	 p->vdso_data[1].seq = 1;
> 
> For a normal task the VVAR pages are installed in the normal ordering:
> 
>        VVAR
>        PVCLOCK
>        HVCLOCK
>        TIMENS	<- Not really required
> 
> Now for a timens task you install the pages in the following order
> 
>        TIMENS
>        PVCLOCK
>        HVCLOCK
>        VVAR
> 
> The check for vdso_data->clock_mode is in the unlikely path of the now open
> coded seq begin magic. So for the non-timens case most of the time 'seq' is
> even, so the branch is not taken.
> 
> If 'seq' is odd, i.e. a concurrent update is in progress, the extra check
> for vdso_data->clock_mode is a non-issue. The task is spin waiting for the
> update to finish and for 'seq' to become even anyway.
> 
> Patch below. I tested this with the normal order and by installing a
> 'timens' page unconditionally for all processes. I'll reply with the timens
> testing hacks so you can see what I did.
> 
> The test results are pretty good.
> 
>     	 	 Base (upstream)  + VDSO patch	+ timens page
> 
> MONO		 30ns 		    30ns 	  32ns
> REAL		 30ns		    30ns	  32ns
> BOOT		 30ns		    30ns	  32ns
> MONOCOARSE	  7ns		     8ns	  10ns
> REALCOARSE	  7ns		     8ns	  10ns
> TAI		 30ns		    30ns	  32ns
> MONORAW		 30ns		    30ns	  32ns
> 
> So except for the coarse clocks there is no change when the timens page is
> not used, i.e. the regular VVAR page is at the proper place. But that's on
> one machine, a different one showed an effect in the noise range. I'm not
> worried about that as the VDSO behaviour varies depending on micro
> architecture anyway.
> 
> With timens enabled the performance hit (cache hot microbenchmark) is
> somewhere in the range of 5-7% when looking at the perf counters
> numbers. The hit for the coarse accessors is larger obviously because the
> overhead is constant time.
> 
> I did a quick comparison of the array vs. switch case (what you used for
> your clk_to_ns() helper). The switch case is slower.
> 
> So I rather go for the array based approach. It's simpler code and the
> I-cache footprint is smaller and no conditional branches involved.
> 
> That means your timens_to_host() and host_to_timens() conversion functions
> should just use that special VDSO page and do the same array based
> unconditional add/sub of the clock specific offset.

I was a bit scarred that clock_mode change would result in some complex
logic, but your patch showed me that it's definitely not so black as I
was painting it.
Will rework the patches set with Andrei based on your and Andy's
suggestions and patches.

Thanks,
          Dmitry
