Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3FB317047
	for <lists+linux-api@lfdr.de>; Wed, 10 Feb 2021 20:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhBJTgP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 10 Feb 2021 14:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbhBJTfH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 10 Feb 2021 14:35:07 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD9DC06178B
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 11:34:03 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id d2so1751607pjs.4
        for <linux-api@vger.kernel.org>; Wed, 10 Feb 2021 11:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LxaZ4hziEn9bchFK4AxqUiBcTDlmtg7lC2ZBUIMeIPQ=;
        b=nRz/Y4Y5rIwUL1EuSMgwTQJXMPe2fRzT5faEAJAOhNicQ+O6uXb8rFTVjChcJytO38
         iZzMzgApYK6PyJKIgtWx0b3QyfsAou3UCfKtA7njlDUDBn3dG1Vf9lzcDMklXcV7UQIs
         wJv/CUJiDCLpOS0wR3wJHlX1yC2Cgie/lSZPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LxaZ4hziEn9bchFK4AxqUiBcTDlmtg7lC2ZBUIMeIPQ=;
        b=PZtU1BKGEqjXYcRtsW4p4+e1wt4tlNG2lFy+ASspe7V8I3JSzuab3c6ri+DmNh3GD0
         mbbhciImhWds2S1piJPUTkYUc+WB2/vSMVbi3An1yGfD7RAClnmb9HKLUx3jmYE4GGI5
         n9+eoLsUxi6G8HpIGCYVnnRCT3Hl/SiL4+dW2MuXIvjXfy0UY2sgmA/Bl4gLPeBA6D+V
         JJpDNU4gAhPCDXLbqPOQnXI2wmRzd5wdWe/W/stJxnf61LQJ3MWab6YU9bzmq6OayzPC
         NO2egXKO/0xuaLArKiw7Ird5pOB6/+vxdRC78ceVcR6ca2dHI76flfMOO4LhJdA4V8oo
         45YQ==
X-Gm-Message-State: AOAM530Ln2ugITmsYWsvNwlVJnJlgWYZp4lHL/Jz6FtmILr7E09+zm25
        vqbZos6pEpg214UqSIuryKneYQ==
X-Google-Smtp-Source: ABdhPJyRecy1GRXLP1kMQcH16Sgfnf+QusYUJ4oECanP4lP6AnzDHzMfwFxFC9h1QK8RZDo1gMXKvg==
X-Received: by 2002:a17:90a:4fc1:: with SMTP id q59mr443897pjh.129.1612985643404;
        Wed, 10 Feb 2021 11:34:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm3089727pfj.100.2021.02.10.11.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 11:34:02 -0800 (PST)
Date:   Wed, 10 Feb 2021 11:34:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>, haitao.huang@intel.com,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH v20 06/25] x86/cet: Add control-protection fault handler
Message-ID: <202102101134.CC29A738B@keescook>
References: <20210210175703.12492-1-yu-cheng.yu@intel.com>
 <20210210175703.12492-7-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210175703.12492-7-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 10, 2021 at 09:56:44AM -0800, Yu-cheng Yu wrote:
> A control-protection fault is triggered when a control-flow transfer
> attempt violates Shadow Stack or Indirect Branch Tracking constraints.
> For example, the return address for a RET instruction differs from the copy
> on the shadow stack; or an indirect JMP instruction, without the NOTRACK
> prefix, arrives at a non-ENDBR opcode.
> 
> The control-protection fault handler works in a similar way as the general
> protection fault handler.  It provides the si_code SEGV_CPERR to the signal
> handler.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
