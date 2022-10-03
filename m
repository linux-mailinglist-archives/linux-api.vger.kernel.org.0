Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21505F393B
	for <lists+linux-api@lfdr.de>; Tue,  4 Oct 2022 00:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiJCWmA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Oct 2022 18:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJCWlo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Oct 2022 18:41:44 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB244220D5
        for <linux-api@vger.kernel.org>; Mon,  3 Oct 2022 15:41:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f193so10929556pgc.0
        for <linux-api@vger.kernel.org>; Mon, 03 Oct 2022 15:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=0AA5mVx1sjanEJNpz1kP1A24AwPL5AGSN+ESikM8G4M=;
        b=VA2wkSxhEFL+eKy/lIFXjIKz1DzSfgSEefJ5rtjsj1q3frLFZQ6mzW1Ed9JI45s1Et
         XmjWZkilsyMHSNjclxEoFDGnZTfYZDl+r9V2QIu6bDOLlLa4Kuu+OuF8h52H5ga/S4EA
         6TZdBYRGEkRcIyvWs1l2snBK2VDH6Lsko7fGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=0AA5mVx1sjanEJNpz1kP1A24AwPL5AGSN+ESikM8G4M=;
        b=eVIeFakbGvsNe3royDB9P/muDCddV4+9VcxSSDXsU0b+7/QDw1XObknOrOUwMhDfoF
         S9KGAULnHHwvW+aHkO7d0fsVXJ7ISJzJ3zi+aZt/ZzxXdlF0/26sDuDNdeLEw8W9hN/t
         PQMicefuJFb/rrRFcm47/uUMZ+XOsQjRtNV09UNEH0tKZKIXbTdAg5X9C60WK+NZeJJM
         VUHTEaHQWCwkr4gs/mRK4frA9lOYUfZjhTTrt+r5fgX8uoNEmMnmy8Q1u6qjkLQGXEpN
         QINT/SCqSOtgoOoK6pvQfNhGlPP/z94HVKWxhTJyonwslhlMVnG3QL+flSsimFWLa7b9
         mbwQ==
X-Gm-Message-State: ACrzQf0krOx7iGFukVORoJcK7SJgTKxQW/VpXnnk2lBkVsb79TazaPtJ
        WbtRcGUdtCWPO/n+h1mEJHKgdQ==
X-Google-Smtp-Source: AMsMyM6KFn3hsaPQ+/v9SY9Is1u0aX6T3pdbvPhrAobSs1cgE1Gpo2NXEvxIOkgpxZZP5yLEsTyAnA==
X-Received: by 2002:a63:1f5f:0:b0:440:5310:4b0e with SMTP id q31-20020a631f5f000000b0044053104b0emr19679572pgm.293.1664836902512;
        Mon, 03 Oct 2022 15:41:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13-20020a170902650d00b0017d665117dasm5499305plk.150.2022.10.03.15.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 15:41:41 -0700 (PDT)
Date:   Mon, 3 Oct 2022 15:41:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Subject: Re: [PATCH v2 31/39] x86/cet/shstk: Wire in CET interface
Message-ID: <202210031539.CD26B37269@keescook>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-32-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929222936.14584-32-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Sep 29, 2022 at 03:29:28PM -0700, Rick Edgecombe wrote:
> The kernel now has the main CET functionality to support applications.
> Wire in the WRSS and shadow stack enable/disable functions into the
> existing CET API skeleton.
> 
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
