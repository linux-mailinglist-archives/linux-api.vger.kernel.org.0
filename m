Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0908F6102
	for <lists+linux-api@lfdr.de>; Sat,  9 Nov 2019 20:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKITDa (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sat, 9 Nov 2019 14:03:30 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33826 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfKITDa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sat, 9 Nov 2019 14:03:30 -0500
Received: by mail-io1-f65.google.com with SMTP id q83so9944649iod.1;
        Sat, 09 Nov 2019 11:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=Ky8i6DH02Cw8Up3tbmxnMON4rbULPGXfpUOWLgdMN8R4toBX7AL1N6gYAfgf3dXUZW
         40oMJvowRdvhLhD45R9khEk2Y37CWr5cChz32DrSXzu6F3FNqnU1xgtVJpC39SwPKGjA
         8pS2HOuFiMKwGvfHU9dImHd8NmxjI2ilFvLARxpb+LNnwfC2Mr+eiySuHm03gKvRaCb2
         20nnUQeZKLYraR+zn3pNbQM2JepvKHuRHuWjt2171ziMIQ9nhD0INJ4yaCS91EgBuKCS
         JMSZO1a08fkyA8OfElmaTLUEsdWdn8LzPTxK5jkvFLoVY1lvg+UKkl8OXLjGm+QPDGRt
         d6Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m3uHaDtX3ciBcivMZkabAXv4IXjFfi/2JONmJEnyS4M=;
        b=kOk7k9JteLvgNOHs1Ha6LbpkaRBn4xjqe+fwy36FRpBNrHqFCBVxyWXboUlL59CHE2
         yZxnHJVtanVg0KGGE/I/yGzX2OOhCjNraffU0uECo6V53+gsIak/WWvlKFKcl6cZM836
         6J06UqR7NtgemlsTKj9wWf/Z3SLB+z+N56fkdH8YVHxYxbEkg+iUHuw7t3zMfUC7BZla
         85DNow8Vn6Z0+z3wjVBouJYZvs/xjnq1mbJZ2mL3S1Z5jIBTtuc/Z1TixUTCzo5iVXZK
         ct5juRE74MUgA7QOoVkOk3fAjvsUHgZou5hw6bvGSvJqWy+ZfmNkVIdunLmDx7pR4NYX
         PEBw==
X-Gm-Message-State: APjAAAXHVX3MV9ntJCHc9+t3acc4VNHOJs4l0XlMKWcn8+d8XLVjI1b0
        DhAIq4bwBK5hcrMbv9YWRcqQM71PsWgnF6au/tI=
X-Google-Smtp-Source: APXvYqxIP+MENNIHntME/L9refFirwkXlKLfA02jS2BqkMzkPUV7GBZjAKJYpHN5spmlDkqXwwNHtidXZGgsmW6XKZs=
X-Received: by 2002:a6b:3c04:: with SMTP id k4mr8523933iob.110.1573326209665;
 Sat, 09 Nov 2019 11:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20191108210236.1296047-1-arnd@arndb.de> <20191108211323.1806194-1-arnd@arndb.de>
In-Reply-To: <20191108211323.1806194-1-arnd@arndb.de>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 9 Nov 2019 11:03:18 -0800
Message-ID: <CABeXuvrqnKtJBJHC+SQ+f1b395Jh8DO4GDweME4eNKrX6LFfxg@mail.gmail.com>
Subject: Re: [PATCH 10/23] y2038: uapi: change __kernel_time_t to __kernel_old_time_t
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Acked-by: Deepa Dinamani <deepa.kernel@gmail.com>
