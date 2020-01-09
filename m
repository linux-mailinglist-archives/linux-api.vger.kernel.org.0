Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5D135BC7
	for <lists+linux-api@lfdr.de>; Thu,  9 Jan 2020 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgAIOx6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Jan 2020 09:53:58 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51883 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731826AbgAIOx6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Jan 2020 09:53:58 -0500
Received: by mail-wm1-f50.google.com with SMTP id d73so3245840wmd.1
        for <linux-api@vger.kernel.org>; Thu, 09 Jan 2020 06:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rUxPHa2T/qhjfPbBGgKT0jw2Pzfyyz7G8V70ESCMcRw=;
        b=V6FQkdls3RdCEqF/mu2mah0JUBnQeCeA2/rmb4KqnquLCXhwFabSCLIUAtoGpGytTu
         hs37ORj+RgTBBs6BP0kEDsoaqi7d1zj01UB5OvxuJKUmulPxpZmXE5S6BEcYsUxzp6hn
         17Z+yZ1Kw/5ysSD5DVe7CvuGiTqVJjmXixcog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rUxPHa2T/qhjfPbBGgKT0jw2Pzfyyz7G8V70ESCMcRw=;
        b=sHAFzoSC5Ic/HXby9Xb/RxJ44MkQC3Zkao789ZFHA9HMu0I6pZ5hyu4XMJoSQaUJ2C
         rfpWIKfdJ4kd6dp8cfnDpg2WbwpsKildnBxQ0Y7TUDoMCSGSJFjaWMOt4QSUoJNAhX8O
         v5BUiz9JTuoS+YPmbAqHdmQfQ0SX2E8U9kBvpYUMDbhCOdmYwPW1Nsrrtw1khc1IwPyn
         d+9Ft5Mjo6m4jCErn1J0k/9v3yqpDQYwYTUV69VQvPCvtK/y/REbyDrSESkEQFTKRDJR
         xN1hMRlKWwo8P5p3fxDHNUIrhaqkKOfM1HYsCqvvxoDw1Q0lL3bKLRCqnCq8mZ+4MuMs
         /41Q==
X-Gm-Message-State: APjAAAXAXQTeAhJLS0e3Tw+RhlL7NXb5zC7dQUvOD7U7yL3Pr6fJ3f8i
        UXh1Solu0Ogt/wsrm4jKZyr3rg==
X-Google-Smtp-Source: APXvYqzq0xB087gtDch3VgcD10JC1IwNoOD11dTRRE2inBUSxt3yaAvEH7p8AntjfBQlsiOZ0U8ijA==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr5240117wml.138.1578581636799;
        Thu, 09 Jan 2020 06:53:56 -0800 (PST)
Received: from localhost ([2620:10d:c092:200::1:37ce])
        by smtp.gmail.com with ESMTPSA id p7sm2966892wmp.31.2020.01.09.06.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 06:53:56 -0800 (PST)
Date:   Thu, 9 Jan 2020 14:53:55 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND v5] x86/resctrl: Add task resctrl information
 display
Message-ID: <20200109145355.GC61542@chrisdown.name>
References: <20200109135001.10076-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200109135001.10076-1-yu.c.chen@intel.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Chen Yu writes:
>+#ifdef CONFIG_PROC_CPU_RESCTRL
>+	ONE("resctrl", S_IRUGO, proc_resctrl_show),

There was already some discussion about "resctrl" by itself being a misleading 
name, hence why the CONFIG option eventually became CONFIG_X86_CPU_RESCTRL. Can 
you please rethink the name of this /proc file, and have it at least be 
"cpu_resctrl" or "x86_resctrl" or similar? :-)
