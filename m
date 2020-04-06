Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304D519F525
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 13:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgDFLuk (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 07:50:40 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:44150 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbgDFLuk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 07:50:40 -0400
Received: by mail-pg1-f173.google.com with SMTP id 142so7409506pgf.11
        for <linux-api@vger.kernel.org>; Mon, 06 Apr 2020 04:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eSEYeGHJW6L1yFZdjvZu8BXqsVS6+Imz64kPAhoNehc=;
        b=EVHI8E2HsQJ9Svnqp+R7hSaCboaInyxUjdHuKNMRYaAqw5fsam3DG39gWQgpdFNaBM
         IVZBl4jvVImZHpXf7WHBYPhkPNwaUgr3HWmQ7eyVptt+1tQcAbJNGqeCbUc9L/iFPukC
         jH7zHJWalVPlP6OcmvBNWSpflfGaooqDmqL4UcteTQg+StXxC07N+g+ZdLOArukrSS+2
         KP82QOWORNZ4eCLxuXVU1rfbBbXUNQLQDarzkT39jLEPXSu+hmCYJyKGgkJDA+444lJK
         D+IrrKM38coX84i+GYBhQmjcb2yR4BWeOGdv/0sUCIcDZXPty+OIuQHyCYyDDAYbkhuw
         d7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eSEYeGHJW6L1yFZdjvZu8BXqsVS6+Imz64kPAhoNehc=;
        b=mngHxnbQBqwym/7nrb24p8hp+4cqCocnkTdEkuQ/PPZBuhltf4kMayAhAd3JR/ywTl
         ZrUohWW2L0JXobuA0ZSvhh4g9MvhUpzwREsFfdbkJWUP+Mq4d0b+gjdXVmoY4n0tPJnx
         zMfaOeRJYwi8IBMznr6yL2T1Jo7qw+ZqXlru6OUFCGKd1boyfFm8FdMQ3bhu743f7/Oq
         TAF5tqqWHWwkGMaj6GMUJVqlpZsUCy5iwmqvRuWJdySg0GlzCtGVU5TkERbEGUq+MCU4
         /53H6+P9e9/GQj8Tjj1UxadJnL7Dh6ctbZCon+3WoLp6kXO5sRiJ/mvOjHrnXrcl3FUj
         gjew==
X-Gm-Message-State: AGi0PubA975o/NERHsWyCJtnDY40W4DBgB2RxLw87dPTGNqPy5W/Zx4M
        xIWw5R7CZCcwshVRXLsCXKrudA==
X-Google-Smtp-Source: APiQypJbSk9nhcIBkVtji01qlTReiqSK+1z9CtKxnbEsDtTA6Mr0Dhzwjf+aZwsQgRIaFpUTWaZjSQ==
X-Received: by 2002:a63:6346:: with SMTP id x67mr20405820pgb.67.1586173839100;
        Mon, 06 Apr 2020 04:50:39 -0700 (PDT)
Received: from ?IPv6:2a02:8084:e84:2480:228:f8ff:fe6f:83a8? ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id k6sm12024505pje.8.2020.04.06.04.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 04:50:38 -0700 (PDT)
Subject: Re: RFC: time_namespaces(7) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andrei Vagin <avagin@openvz.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Containers <containers@lists.linux-foundation.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <a74763df-6523-2103-b687-27cae3a433fc@arista.com>
Date:   Mon, 6 Apr 2020 12:50:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

On 4/4/20 12:08 PM, Michael Kerrisk (man-pages) wrote:
> Hello Dmitry, Andrei, et al.
> 
> I have written a manual page to document time namespaces.
> Could you please take a look and let me know of any
> corrections, improvements, etc.

Thanks a lot for the man page. It looks good to me.
Maybe Andrei will find some nits, but I don't have any in mind.

Thanks for you work,
          Dima
