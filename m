Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A72193046
	for <lists+linux-api@lfdr.de>; Wed, 25 Mar 2020 19:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCYSXm (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 25 Mar 2020 14:23:42 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39677 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYSXm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Mar 2020 14:23:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id a9so3921376wmj.4;
        Wed, 25 Mar 2020 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=C32w3s9xrOfvpUyGe59pEMLZJTy5zL32E35LnVR5hYc=;
        b=FgeLTpJO4Hkgg/xBcD+rSToh1De74uOGAMziQcy+E4+bS+PD6mET09MPFOxZHV/plJ
         gx5rMJ8TSlpE1+WagyKKtE8TQMDETgDNcy0Hv4AuhxwekkFR7HrW4fPxt8FpKduA2M0V
         iUagoSf+VveNlRNEyaKZyTLCq0WR0HwclUv+A8AQCqfwPwtzZ6KL0Pl8ntY7DOg3Gg1r
         PhLPh/BimzjRi2vmHnwzZwvCbIrSGp4Cs46b7HM3BWn+di666a7YKxAFgpZ1hiQSESJS
         AbR8MK4VbZBjXgBKR0Vbi4VjnnqLkB1Hfh30vxW8Q/cSjx/+fyEptWlJ1u9D1qrtpgWA
         eg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C32w3s9xrOfvpUyGe59pEMLZJTy5zL32E35LnVR5hYc=;
        b=H64QN31JjAk5pvzTmwsoFt3kMI70doeRjSuGZjAV60l/e5J7BWJPayZ+fC/m/n73OG
         gmIJGiEsGkouKnLZFJKWQ7+Xf0tAp2yIFAIRr5mGHhti5Y9ORpbUoom/4h3YwkrBj1bH
         ChO/4NF2hxfsvCvE+hQjllAbpvtZ1TGS2DQWco7+FFIiuM4CQOYGKm3R30+Ac8uH1n3N
         vVt87t8nfbcJZ/0PcdErrQWoYgfdZWACfShG8xAsDDV6REH1iAPPptUEMFEeyG6ybwJx
         OmjW2ohqXkgB1zyk3OhFiQN2U6jtzGwYl1k7mXgT/Ovmvo6Q+UhebR1htNrGafuNWpHJ
         7R1Q==
X-Gm-Message-State: ANhLgQ3EU74ThIhdX4JFtl9uJRY7B3wDmhi4f1On00HLGsBrm+kS1MX4
        6uRaK58J6j4a10V9/Pg5XA==
X-Google-Smtp-Source: ADFU+vsyiCNldnGZBS245ltWuorhNkb+GBDqN+91mRMhKnL924K5FAfhJhhUpMKtKLWUYXbmqq0qAA==
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr4853440wmj.155.1585160619868;
        Wed, 25 Mar 2020 11:23:39 -0700 (PDT)
Received: from avx2 ([46.53.251.45])
        by smtp.gmail.com with ESMTPSA id m3sm4298649wmm.3.2020.03.25.11.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 11:23:39 -0700 (PDT)
Date:   Wed, 25 Mar 2020 21:23:36 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>, leon@kernel.org,
        vbabka@suse.cz, akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, kasong@redhat.com,
        bhe@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, linux-api@vger.kernel.org,
        kexec@lists.infradead.org
Subject: Re: [RFC PATCH v2 1/3] meminfo_extra: introduce meminfo extra
Message-ID: <20200325182336.GC18706@avx2>
References: <20200323080503.6224-1-jaewon31.kim@samsung.com>
 <CGME20200323080508epcas1p387c9c19b480da53be40fe5d51e76a477@epcas1p3.samsung.com>
 <20200323080503.6224-2-jaewon31.kim@samsung.com>
 <20200323095344.GB425358@kroah.com>
 <5E79CEB5.8070308@samsung.com>
 <20200324101110.GA2218981@kroah.com>
 <5E79F102.9080405@samsung.com>
 <20200324114645.GA2330984@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200324114645.GA2330984@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Mar 24, 2020 at 12:46:45PM +0100, Greg KH wrote:
> On Tue, Mar 24, 2020 at 08:37:38PM +0900, Jaewon Kim wrote:
 
> > I don't know other cases in other platform.
> > Not desperately needed but I think we need one userspace knob to see overall hidden huge memory.
> 
> Why?  Who wants that?  What would userspace do with that?  And what
> exactly do you want to show?
> 
> Is this just a debugging thing?  Then use debugfs for that, not proc.

Yes, please use debugfs. Android can ban it in production all at once.

> Isn't that what the DRM developers are starting to do?
> 
> > Additionally I'd like to see all those hidden memory in OutOfMemory log.
> 
> How is anything hidden, can't you see it in the slab information?

There real usecase for something like that is vmware baloon driver.
Two VM instances oversteal pages one from another resulting in guest OOM
which looks like one giant get_free_page() memory leak from inside VM.

I don't know how often this type of issue happens nowadays but countless
OOM support tickets were filed and closed over this nonsense.
