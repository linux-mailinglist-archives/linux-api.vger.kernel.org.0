Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344A1EEDE6
	for <lists+linux-api@lfdr.de>; Fri,  5 Jun 2020 00:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgFDWpt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 4 Jun 2020 18:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgFDWps (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 4 Jun 2020 18:45:48 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA98DC08C5C1
        for <linux-api@vger.kernel.org>; Thu,  4 Jun 2020 15:45:48 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e9so4151273pgo.9
        for <linux-api@vger.kernel.org>; Thu, 04 Jun 2020 15:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/Ifpw3zohhhizup/iPeLdkC3yBceaz+iR6KHJ3Yp7w=;
        b=SrQ7VnScu3Op+k3qtU1bTlBve/IrhoIvaPcQQfuMsKsMtmX3GiGycjsmpSaJ2AnuDA
         sLq4MjD67cj2rWV6lZm9AXde9aoXtHyST0fTrFSBtBortq/FKnBoCzc4AjAVf67w4Qok
         MGxBkAmDISkBXLpBye8qEIXP9D2ZMSO395T7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/Ifpw3zohhhizup/iPeLdkC3yBceaz+iR6KHJ3Yp7w=;
        b=llb05poF3SuSl1+kgsvNAVsyi/yISUECdM31glhCVELJN1nrNYVmWdSTp5jLidH3oB
         WhUrCwpZv+Gq658xuLpPyAnlrk0bj9LS/Uj1f8AqZXH8GdqSBtmhlnE0P+wk0J1Zxqpc
         psc3HCDFfsJEprKLkTtjeUO+GLs03XR87FFKq7wLOiblW4Bfz+ErvJepz+fE9QzC6tIW
         xJQdkJs/9kTiWNn+AWvuMHMWGU6CD2ym8EFDCMYZFO2P/CMKhx9yOvheR8vDotn3twoG
         y9a6E71NkNrlJFTDPIHjBrYP8xgARdWmW4JuCAR5DtXw2bY1/xf1LkWgk89EX8iR+rYT
         Xp9A==
X-Gm-Message-State: AOAM532eadnHPSYVE6pZzffFOJIklf9r+dx7pOFk6SfJNb3Irt4qdTJj
        qjyWVS2OzpQBw/HukmzxrHgTtw==
X-Google-Smtp-Source: ABdhPJyN4dzHONC8ss9AIERs8X2Xzk+pU9aR8JSs6krPWrNtYee6rEeKAqIdDe6qG44ooQ6X4qDCxQ==
X-Received: by 2002:a63:f856:: with SMTP id v22mr6764340pgj.64.1591310748187;
        Thu, 04 Jun 2020 15:45:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b10sm5065247pgk.50.2020.06.04.15.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 15:45:47 -0700 (PDT)
Date:   Thu, 4 Jun 2020 15:45:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Eric Biggers <ebiggers3@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org, ltp@lists.linux.it
Subject: Re: [exec] 166d03c9ec: ltp.execveat02.fail
Message-ID: <202006041542.0720CB7A@keescook>
References: <20200518055457.12302-3-keescook@chromium.org>
 <20200525091420.GI12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525091420.GI12456@shao2-debian>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 25, 2020 at 05:14:20PM +0800, kernel test robot wrote:
> Greeting,

(Whoops, I missed this in my inbox.)

> <<<test_start>>>
> tag=execveat02 stime=1590373229
> cmdline="execveat02"
> contacts=""
> analysis=exit
> <<<test_output>>>
> tst_test.c:1246: INFO: Timeout per run is 0h 05m 00s
> execveat02.c:64: PASS: execveat() fails as expected: EBADF (9)
> execveat02.c:64: PASS: execveat() fails as expected: EINVAL (22)
> execveat02.c:61: FAIL: execveat() fails unexpectedly, expected: ELOOP: EACCES (13)
> execveat02.c:64: PASS: execveat() fails as expected: ENOTDIR (20)

I will go check on this. Looking at the expected result (ELOOP) I think
this just means the test needs adjustment because it's trying to
double-check for a pathological case, but it seems their test setup
trips the (now earlier) IS_SREG() test. But I'll double-check and report
back!

-- 
Kees Cook
