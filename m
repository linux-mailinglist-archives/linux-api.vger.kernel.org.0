Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB58CB0C6
	for <lists+linux-api@lfdr.de>; Thu,  3 Oct 2019 23:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfJCVF2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Oct 2019 17:05:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43679 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbfJCVF2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Oct 2019 17:05:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id a2so2499061pfo.10
        for <linux-api@vger.kernel.org>; Thu, 03 Oct 2019 14:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EiltBEq6njqGNMiV0WVZrSDJVepz/r4bkWK6+Mlhtls=;
        b=h15edSAOeAVO6+isDrz0W6jcs1RlAD347T43CXwfP6aj516mFy9O19/PPmYCkrcFAy
         8ZZDObjG8qPgpYcPLivDmXHq0y38Rv2EarhS2mGFXA16kD4oew1n/UDzu96ifq0sZWd0
         QwgfPrCQlt2u9uAiDHKRaued1dnb7vheuPGGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EiltBEq6njqGNMiV0WVZrSDJVepz/r4bkWK6+Mlhtls=;
        b=o9ljM/eMBn0UpAJsOTd28mNoRi04r0kmjsIvoRQxzkiuErq81yu0p1EGev44WaqhxS
         h7k0KWVaQPmeTAm9Z0DzkDIsgYtwcPdAZdgUEQ+6pWegtKmRwLSu6PEXW9WHIaJiE+Vg
         ZDyW8Q1Psh4JlasrJDlrtyXZQBA+KkFNF1s1OPAkQAHQDx81MzcB6Ibt7M7zwNLm5bD4
         ysjORo/boJjxd26PLecm9P7fy4ZFiKq7K3/bd6uLLfBHpyjm0qZb/G15yPWn82gsradj
         ndyCzy1wh8j74vo1/E/Kf5QnGYELROf71gz/+XvkljIlUykN1pt7bMhnYwFNEyxI+vX+
         zpxQ==
X-Gm-Message-State: APjAAAUQNWL70zQ+YIA0UDnrNZmKmV0JQWQ8QoAyKgXVGwK94fg/D8Nu
        9foAukKjmfczj+2ioqQWIkEt5A==
X-Google-Smtp-Source: APXvYqwjSuvsL3+nr1PLtA1rKl85DoBCn/uehIlb3OTXV0Cx3UdB9yBzNVCmiNsnR3ZDRn3AOqIfXg==
X-Received: by 2002:a62:3585:: with SMTP id c127mr13074356pfa.18.1570136726099;
        Thu, 03 Oct 2019 14:05:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y17sm5554361pfo.171.2019.10.03.14.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2019 14:05:25 -0700 (PDT)
Date:   Thu, 3 Oct 2019 14:05:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Helge Deller <deller@gmx.de>
Subject: Re: [REPOST][RFC][PATCH] sysctl: Remove the sysctl system call
Message-ID: <201910031404.C30A0F16@keescook>
References: <8736gcjosv.fsf@x220.int.ebiederm.org>
 <201910011140.EA0181F13@keescook>
 <87y2y271ws.fsf@mid.deneb.enyo.de>
 <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv8pftjj.fsf_-_@x220.int.ebiederm.org>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Oct 03, 2019 at 03:44:32PM -0500, Eric W. Biederman wrote:
> 
> This system call has been deprecated almost since it was introduced, and none
> of the common distributions enable it.  The only indication that I can find that
> anyone might care is that a few of the defconfigs in the kernel enable it.  However
> that is a small fractions of the defconfigs so I suspect it just a lack of care
> rather than a reflection of software using the the sysctl system call.
> 
> As there appear to be no users of the sysctl system call, remove the
> code so that the proc filesystem can be simplified.

nitpick: line lengths near 80 characters

> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

But, yes, I would love to see this gone. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
