Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37DDDC405A
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 20:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfJASqs (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 14:46:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34538 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfJASqs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 14:46:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id y35so10314933pgl.1
        for <linux-api@vger.kernel.org>; Tue, 01 Oct 2019 11:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mxe0c+vkfTxTPI/lCIAC+7CvdlZWYOh086O484Rpftk=;
        b=fCc3abs0hkgn+uL2s0AFi4DSOOt3h4SozmAECb/n3o3xXvcyCF1PlHlb639eFrT5wE
         dsIylNlNSoxdeH79i+AlH55WksngorSLCQvqzpNtVEK62w4rh/pfaEgmfyzTjOxqmNKV
         JzZJ+Q9UJZtr4aoW4JIcMiqRaFnvUl5nffIMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mxe0c+vkfTxTPI/lCIAC+7CvdlZWYOh086O484Rpftk=;
        b=Eie+uqMvs877+4SwGPmd7hoZAUWYYKxZ+2X71z8kDmuNs4NKsiiAc53AvFodc/5gI3
         tv2HogI4KvS8U0X0eWaJprphbEbIhfIs8hXUElcST9bDl7eePDf0XQEHMY+cKssTqh57
         1lstdtqLwGEVn+1czr8oHLCDLiQ53P4UerbxvZOhqOzJcN2/cXqF29ove9KZfg4CqVAt
         bt9LwY9lXyhNX4xu9QETdil0+hmuXjq5Uy6TslZNXiHnMO0ftm7stGjOBouhCkoszOn/
         hbr7c5/msfo+ysDF9QbsIV3xKRwcVYzVFnNVRBm5+1q7tdfCOnoFmyfa1M42GbJw7x8u
         EL+A==
X-Gm-Message-State: APjAAAXqFXiw9F4dG9OsmZnk2O8zTqKyWc6E6NBAuzbT5AV7Uot2B1EF
        iWRD0wqvn5prlFNdnSaXB4ZrGA==
X-Google-Smtp-Source: APXvYqzkZUi1wRq28kH7tBwMjb8Eq+5VSPTImorMe/hF6ICk4a/PEf32C3ZJvkiDm/2R9ZCwKpPeoQ==
X-Received: by 2002:a63:4cf:: with SMTP id 198mr31798060pge.105.1569955607566;
        Tue, 01 Oct 2019 11:46:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g24sm16750072pfi.81.2019.10.01.11.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:46:46 -0700 (PDT)
Date:   Tue, 1 Oct 2019 11:46:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <andi@firstfloor.org>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        Anders Berg <anders.berg@lsi.com>,
        Apelete Seketeli <apelete@seketeli.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Chee Nouk Phoon <cnphoon@altera.com>,
        Chris Zankel <chris@zankel.net>,
        Christian Ruppert <christian.ruppert@abilis.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Helge Deller <deller@gmx.de>, Hongliang Tao <taohl@lemote.com>,
        Hua Yan <yanh@lemote.com>, Huacai Chen <chenhc@lemote.com>,
        John Crispin <blogic@openwrt.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Josh Boyer <jwboyer@gmail.com>, Jun Nie <jun.nie@linaro.org>,
        Kevin Hilman <khilman@linaro.org>,
        Kevin Wells <kevin.wells@nxp.com>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Noam Camus <noamc@ezchip.com>, Olof Johansson <olof@lixom.net>,
        Paul Burton <paul.burton@mips.com>,
        Paul Mundt <lethal@linux-sh.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Pierrick Hascoet <pierrick.hascoet@abilis.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Roland Stigge <stigge@antcom.de>,
        Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Scott Telford <stelford@cadence.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Tanmay Inamdar <tinamdar@apm.com>,
        Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <201910011140.EA0181F13@keescook>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8736gcjosv.fsf@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Oct 01, 2019 at 01:36:32PM -0500, Eric W. Biederman wrote:
> 
> This system call has been deprecated almost since it was introduced, and
> in a survey of the linux distributions I can no longer find any of them
> that enable CONFIG_SYSCTL_SYSCALL.  The only indication that I can find
> that anyone might care is that a few of the defconfigs in the kernel
> enable CONFIG_SYSCTL_SYSCALL.  However this appears in only 31 of 414
> defconfigs in the kernel, so I suspect this symbols presence is simply
> because it is harmless to include rather than because it is necessary.
> 
> As there appear to be no users of the sysctl system call, remove the
> code.  As this removes one of the few uses of the internal kernel mount
> of proc I hope this allows for even more simplifications of the proc
> filesystem.

I'm for it. :) I tripped over this being deprecated over a decade ago. :P

I think you can actually take this further and remove (or at least
empty) the uapi/linux/sysctl.h file too.

-- 
Kees Cook
