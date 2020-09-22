Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843F6274940
	for <lists+linux-api@lfdr.de>; Tue, 22 Sep 2020 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIVTfo (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 22 Sep 2020 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgIVTfo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 22 Sep 2020 15:35:44 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D6C061755
        for <linux-api@vger.kernel.org>; Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w7so13410396pfi.4
        for <linux-api@vger.kernel.org>; Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WbYiGPaybdIjvQ+aM1gmKUMUqUqOUcyzK5+y//AWywg=;
        b=MjLMSQU8nw9L29XJQBUOQA7cnbIucyL2U5ZxjCyPh/XbOwj84fwbtj5x/llHbz4aob
         QNV3RWFvNeyZTe1lDagS6+aL1ASK65fKy2uuO0qv5V6fsidZazWrSjffC3Txx4ytRl+G
         W9dD02McVkkz7Gz7D4FXGgmr9BAhOPlJQWLX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WbYiGPaybdIjvQ+aM1gmKUMUqUqOUcyzK5+y//AWywg=;
        b=rPuAG2xIbtoFskEcJf809C8q3uvcKzu0XNnHoLOo3wC7wcvr9GSo0KD//vQVEZBnnJ
         gt8jyzPHy/lFixWg/ZXgnb7lD9na1cMGcstdO/t0oxuBrCxlE0pgoC+CKeYMBthy3Jyz
         uOVeViKKnzwuPHZ7Si9UFOHuaxWTA1N/SVtvokSWBEZVcC0KhfVxSjkzNi2i13bAvyzu
         gQwX4EITuIFKK9Ble+eZUrbwYPPGpJ7HL7VdIgpAPABnnF7ntIjkF4OTLWN0GW3d1n0a
         5iTDG40Zvr++NoTGzQj7asql9IAbGy6ZriX9TtiADLXoRUboPtDMyrNqrkJCihI+eRG/
         aw3A==
X-Gm-Message-State: AOAM531qzZ9jv2qi4aWSauZ+aKyrYSH2raJCRkwc89ahhDRZO6sI5gw6
        aU9+v2adYW4CKwML2o/9zMr6T/1wU1/1aho/
X-Google-Smtp-Source: ABdhPJy2r619sV8SMosETdDrfCQJYznE5K4cHeHTbz8NixPikPkrRbDPM2oXz9x2mc9uGCSXGUFZXA==
X-Received: by 2002:a17:902:7594:b029:d1:e626:ef9e with SMTP id j20-20020a1709027594b02900d1e626ef9emr6247059pll.67.1600803344016;
        Tue, 22 Sep 2020 12:35:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fu11sm2986040pjb.47.2020.09.22.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:35:42 -0700 (PDT)
Date:   Tue, 22 Sep 2020 12:35:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, kernel@collabora.com
Subject: Re: [PATCH v6 9/9] doc: Document Syscall User Dispatch
Message-ID: <202009221235.50986D9@keescook>
References: <20200904203147.2908430-1-krisman@collabora.com>
 <20200904203147.2908430-10-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904203147.2908430-10-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Sep 04, 2020 at 04:31:47PM -0400, Gabriel Krisman Bertazi wrote:
> Explain the interface, provide some background and security notes.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Looks good to me!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
