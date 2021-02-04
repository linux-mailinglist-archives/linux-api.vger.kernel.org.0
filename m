Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52FA30FD56
	for <lists+linux-api@lfdr.de>; Thu,  4 Feb 2021 20:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhBDTxu (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Feb 2021 14:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbhBDTvh (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Feb 2021 14:51:37 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADE6C061797
        for <linux-api@vger.kernel.org>; Thu,  4 Feb 2021 11:50:11 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id z21so2866932pgj.4
        for <linux-api@vger.kernel.org>; Thu, 04 Feb 2021 11:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/xqrcr0spyydoAlLuc99uq3cskkQtgF/Uv01pgyq0ds=;
        b=Du7iFlDWFI6enawRDcehFsluT1W0OthyU+AXhyMr2mtTzw5vkuy1H9ceFkQ99qBJSj
         YRZMriPtX53oHb/EVc4MsIXCaJaAWcAnrhRVJuNdh31kUgip6KfbWaqBmyGFYUzIukx5
         G+L+T8Il52MlwCw8EchSrWSoJXEI9rmSN/3Nw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xqrcr0spyydoAlLuc99uq3cskkQtgF/Uv01pgyq0ds=;
        b=t248dYVuIaM1Xl/YLTlIZ5Vn6eW35K89JRkCsQeC0y1BNFvwKiiUy+Y5CCPmNVhduJ
         iYQs+lOH5thn093LdN5MDpbN7ssLoHhQY7bFm6eI3Byc0+eoXHAA3RTwttiFheo236os
         grDcgXDfBcDcJ+6AnNEB7kaySRFhtafuHON2Dqt7V7RNbTmC54PRaXKMNVBHyKNaxGy+
         qXZzZkGsLzXtSaZWO6FtnceCtVBnAVJ1KDohNrxakptDJ9cwtu0wGqfFgeeL/RnwmbJO
         MRdqz/VuOdxy3eFgP6O26LENS7k1SpuuiwmnA/oXdpFrFIZTnCe8BbA6VErJK266+BBt
         srOw==
X-Gm-Message-State: AOAM533WOgRPlZrX/KNNku5cuvsgbsoYtq5530zBdidF28KxjICW8EFD
        J5tkGJsoeI6bWn6Az7Nxow+e4g==
X-Google-Smtp-Source: ABdhPJxtHH5uZ1Z7iC4WZebLw2vn0Wmq76brvfnWdJDqyjrAJu644mdWx5Auq5N/jwzL0m0zXveDdg==
X-Received: by 2002:a62:ac06:0:b029:1cb:35bc:5e2c with SMTP id v6-20020a62ac060000b02901cb35bc5e2cmr894242pfe.42.1612468211577;
        Thu, 04 Feb 2021 11:50:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z16sm7448343pgj.51.2021.02.04.11.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 11:50:10 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:50:09 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>
Subject: Re: [PATCH v19 3/7] x86/cet/ibt: Handle signals for Indirect Branch
 Tracking
Message-ID: <202102041150.3614663DA@keescook>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
 <20210203225902.479-4-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203225902.479-4-yu-cheng.yu@intel.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Feb 03, 2021 at 02:58:58PM -0800, Yu-cheng Yu wrote:
> When an indirect CALL/JMP instruction is executed and before it reaches
> the target, it is in 'WAIT_ENDBR' status, which can be read from
> MSR_IA32_U_CET.  The status is part of a task's status before a signal is
> raised and preserved in the signal frame.  It is restored for sigreturn.
> 
> IBT state machine is described in Intel SDM Vol. 1, Sec. 18.3.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
