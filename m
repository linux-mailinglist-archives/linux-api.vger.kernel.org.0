Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E58D2C8CC0
	for <lists+linux-api@lfdr.de>; Mon, 30 Nov 2020 19:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgK3S1b (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 30 Nov 2020 13:27:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgK3S1a (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 30 Nov 2020 13:27:30 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D663C0613D3
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 10:26:44 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id o12so8702897qtw.14
        for <linux-api@vger.kernel.org>; Mon, 30 Nov 2020 10:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6SFHLyZ3sYbDiiVwNR+ATp4H+5haS+q2T/30J+JE944=;
        b=HXnKmZeegOvioqXFTHGTnMqqFxXIIS2G5aSFawvr65GXD6hsY1at652t2aakKQq3wY
         mR3ivCMZRjLWyhxqBFZm3XMSY3kDaAqZtHFO5tMSHytAn9aVyuIZE6M29hFeuay85mGt
         j608Ulf40muXTaisF0CLSR3KqERAP1A2iQ0+gY7iSb6zOIxch8wxH/aSU9KtGku/+7Mw
         7aFwq/I/5tGqO+VV2V7cs4G7GIHl1uHiLnoCSU2sNVYZfkt4ktoi9+5iA5HaD5+6oPOO
         tt6JMECHyQek1Yb+OJyax1gmOAS8N5b9PLsR+XKDuMOY+R3ZKcbCRVSu1CY+lUcFrrOs
         w8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6SFHLyZ3sYbDiiVwNR+ATp4H+5haS+q2T/30J+JE944=;
        b=YR12mLEaiHuqinmjLeelAAfehsJaPIgb/SjKxI61xFRuLeCktpiYIOBSY8CZflzK9L
         X3o2l4sRv6fSAxMjNZNw51qSXhGnhnLFK7TAcYZr6ojar7PG8VFOgf7T/VdlxYZ8R87w
         ZYJ3l44Op4uK9IqwSDxhKOweTaRXbg+uEXv+7iXY9bQ1zFvvmvOUVDCJaR9whsltZsKh
         5skKxI2tAWTUOv38DEM5Fo3eg0B9kKk8A0EVReI3FGFZek+CeNplFHjNiU8d/+8TcAvN
         hozUL3KG0EAG0J+AzTjpeu7F4VcO3lne22sdPfc08iTsvTkbPpAhhGTFs9gKVImnL9bR
         gUSw==
X-Gm-Message-State: AOAM530/6fjPTW30wp8GX+QDzX+rqKWffZv4aiTYD7OwlUl1tBQ1LDpM
        qEJoJrb2L5Rz+kTU/GsU9QWrqTvB8SIng/h/od4=
X-Google-Smtp-Source: ABdhPJwEFYmPhF4lZX+VLouAsYcNBU1HIibgMDwU7Z53jyjWOKipNANeGUcQch3Yt7aZHBRiC/6Px6iAWQk0t07O8CY=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:9e43:: with SMTP id
 z3mr24290731qve.2.1606760803272; Mon, 30 Nov 2020 10:26:43 -0800 (PST)
Date:   Mon, 30 Nov 2020 10:26:41 -0800
In-Reply-To: <20201110162211.9207-2-yu-cheng.yu@intel.com>
Message-Id: <20201130182641.29812-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20201110162211.9207-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: RE: [PATCH v15 01/26] Documentation/x86: Add CET description
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     yu-cheng.yu@intel.com
Cc:     Dave.Martin@arm.com, arnd@arndb.de, bp@alien8.de,
        bsingharora@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        esyr@redhat.com, fweimer@redhat.com, gorcunov@gmail.com,
        hjl.tools@gmail.com, hpa@zytor.com, jannh@google.com,
        keescook@chromium.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, ravi.v.shankar@intel.com,
        rdunlap@infradead.org, tglx@linutronix.de,
        vedvyas.shanbhogue@intel.com, weijiang.yang@intel.com,
        x86@kernel.org, maskray@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, erich.keane@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

(In response to https://lore.kernel.org/lkml/20201110162211.9207-2-yu-cheng.yu@intel.com/)

> These need to be enabled to build a CET-enabled kernel, and Binutils v2.31
> and GCC v8.1 or later are required to build a CET kernel.

What about LLVM? Surely CrOS might be of interest to ship this on (we ship the
equivalent for aarch64 on Android).

> An application's CET capability is marked in its ELF header and can be
> verified from the following command output, in the NT_GNU_PROPERTY_TYPE_0
> field:
>
>     readelf -n <application> | grep SHSTK
>         properties: x86 feature: IBT, SHSTK

Same for llvm-readelf.
