Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC9F2DE1
	for <lists+linux-api@lfdr.de>; Thu,  7 Nov 2019 13:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfKGMFW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Thu, 7 Nov 2019 07:05:22 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfKGMFV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 7 Nov 2019 07:05:21 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so2779688wrw.1
        for <linux-api@vger.kernel.org>; Thu, 07 Nov 2019 04:05:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=6BlTQMHHw+Jn2iVg9vXkBzx0Gxjup5Jjor5ThaHXmok=;
        b=cOctnWDH2GaPVMP5PS/wGV232sQhhWdFXi33esKvuNQsM136J+OiCoEMH0E1pQGwYq
         iqpval9oyyyXA9Y/xxuq4KNwIhtLKBJSHKD3TfRyB/WfIio+MefGE/Q7OecyJpyEF63d
         conBFOwp6YExLBFOKsRf7uqsYlz42mOcZD1w4mx1pDSFhC1ZhJYn5LQm3OUGXcIdKVDR
         aWYog1d5R+Xj0AkfVtOYFwIt+/ylOLh1TgEBqdmec1/AbzP2gX35cF44EBXGKcUqebTB
         7dK6jOQ2/LUJt7cu7eWIvmBOEEjByq/GL/6myjxg+cmcQnuNVljXCcelPBLEp7sx9R4w
         gM4A==
X-Gm-Message-State: APjAAAWwYORNbM/pd3JhkL8M51dWHCAc24mSRwm/rJjsYGyTik/NdY0r
        2NTvUBciV68z1wuAaaY+dp+lXQ==
X-Google-Smtp-Source: APXvYqw/U9e+KOsCRz32jkpR6HS+2FjmIgBZSPpmTRE7ozoym720IYdWnBU79dQ4ful73iohXVNUsQ==
X-Received: by 2002:adf:dc06:: with SMTP id t6mr2599330wri.378.1573128319595;
        Thu, 07 Nov 2019 04:05:19 -0800 (PST)
Received: from [10.102.229.175] ([185.81.136.18])
        by smtp.gmail.com with ESMTPSA id q15sm1998294wrr.82.2019.11.07.04.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2019 04:05:18 -0800 (PST)
Date:   Thu, 07 Nov 2019 13:05:16 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
References: <CALN7hCK0EXLXjPRPr+tuuF2-uQvkLMCFDNzGhv9HS-jrAz6Hmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: Continuing the UAPI split
To:     Elichai Turkel <elichai.turkel@gmail.com>,
        linux-api@vger.kernel.org, libc-alpha <libc-alpha@sourceware.org>,
        Florian Weimer <fweimer@redhat.com>
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <0B17C6F2-DC2B-4192-B4AD-BD11D6B9F2B6@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

[+Cc Florian, glibc]

On November 7, 2019 12:17:50 PM GMT+01:00, Elichai Turkel <elichai.turkel@gmail.com> wrote:
>Hi,
>I'm working on a library that calls syscalls directly to the kernel.
>`make hedears_install` is a great command to auto generate the UAPI
>headers that are needed to call the kernel.
>
>But the headers are still missing a bunch of defines for flags and
>structs.
>
>I wanted to know if patches to move more things from `./include/linux`
>to `./include/uapi/linux` are welcome (obviously only
>typedefs/defines/structs that are required for the syscalls)
>
>I think the UAPI is really close to getting a complete set of things
>needed to communicate with the syscalls, but still not quite there. I
>would like to push patches whenever I see missing things that my
>library needs (that way it will be incrementally and by usage only).
>
>Would love to get feedback.
>Thanks,
>Elichai.

