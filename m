Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2419FD62
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 20:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFSpL (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 14:45:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44235 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDFSpK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 14:45:10 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1jLWk8-0006Q7-3B
        for linux-api@vger.kernel.org; Mon, 06 Apr 2020 18:45:08 +0000
Received: by mail-lf1-f69.google.com with SMTP id b24so5482656lff.12
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 11:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=35u7sIzL2v+ZtiB13vYxkmAljAmMWY1VBaJPchGChPU=;
        b=NkGs6Gxoxx9DhdZDHA7gGcGowKgrg9jdi/vYxWr9peA0IP/0E3lkY7VlmB2Ds6S03r
         X6A0kkPMR3ZwsGMbolwn27EMK8+9ytqUkQWgVpiGR4idydkyEqp0xNb3+J1GslzPWxmV
         t0cjkkVOSpbjEq24+7tP5qzF72LFookPXI5oyQAyug/ZcrOFlZMH64ZuaQYRa+brLz2h
         +zjj+ChiG0eg1+TQ3HaKfJ26wfHswJux+4uTJciCodOXoklkuuvN3unzLfmd0wTf5FJh
         bjcEdhvv4T9Yv6iKFMifx0Y6zyVmUh5EVrH+V9ifp9A3YCICJ1H4VXlZ01aHt0P2a8vE
         NKVQ==
X-Gm-Message-State: AGi0PubEw/nbISM5CtbmZN9+WvG4d3pUBv3zFbG8wF/2UMWjqZG5R9FU
        0PKg683S/DwQppngPmRGBCPmjstkMRdTNpqWY0sdKaGPOJOLWTUXt7BRNJFUsmSQU/Rcsqxv37N
        AISdf5etAav+y7X/Wh0bzkno1NDtS97ZuqCRrxWYh70inXEN37m3O/A==
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr388505ljj.218.1586198707569;
        Mon, 06 Apr 2020 11:45:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIfgUD0+Npj1fpuxcNsRprQ6GCvlWvrh7CigDE9Ba3M6ZRRFnD0WowMDyU8FhSHaePkKFsdLtJmDNIULbInyv4=
X-Received: by 2002:a2e:85c6:: with SMTP id h6mr388490ljj.218.1586198707394;
 Mon, 06 Apr 2020 11:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200327223646.20779-1-gpiccoli@canonical.com>
 <d4888de4-5748-a1d0-4a45-d1ecebe6f2a9@canonical.com> <202004060854.22F15BDBF1@keescook>
 <CAHD1Q_xwR4OqsF8n3VJXknZ5QgpLWPQ3YTuztTgn0GTMR0vgKA@mail.gmail.com> <202004061136.8029EF3@keescook>
In-Reply-To: <202004061136.8029EF3@keescook>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Mon, 6 Apr 2020 15:44:31 -0300
Message-ID: <CAHD1Q_y_qzn7=skyDiFnU0cKNMEjiiNSeyK-jqy8qmEdzUKmpg@mail.gmail.com>
Subject: Re: [PATCH V3] kernel/hung_task.c: Introduce sysctl to print all
 traces when a hung task is detected
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        mcgrof@kernel.org, Iurii Zaikin <yzaikin@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Randy Dunlap <rdunlap@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Awesome, no problem at all. And thanks for all the information and review =)
