Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1F5919F0E3
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 09:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgDFHix (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 03:38:53 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42712 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgDFHix (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 03:38:53 -0400
Received: by mail-oi1-f169.google.com with SMTP id e4so12233770oig.9;
        Mon, 06 Apr 2020 00:38:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Koufht6MQGCMD9pxWQ/9qyS9H8jc9VjuJwC2KXdU+5w=;
        b=ki1r8LC0r65WCTpC7lfabHnyKeCnCJQPslWw1fdHjv2crXXIyzzIkYTz/YeTwUKgmq
         VXwI5/2ZXOVXPB1f6M6DSddtW2i57ThPduQkHDO8kKNmZvL8EKy9cTuOkUA7epFXcHAX
         H5qY8S2PDLVUj3RIxwtGtjJT4+8RbOtnSO75Vm9mX219d/Hos+El2ziD6aEEhpDQPBiP
         jhMn8j0zB+3F/KyioBm88O3gN//T5YGHXGU1MhqaDAkmbyJOJa5RFgBBYxO1nSpAowJJ
         1LK/EvV0T5HGFzrdhFdyBIUqufdh4NJWVxerDsoklgEwDWy2h1CrEdg3t79ErgR9U7wo
         YRoA==
X-Gm-Message-State: AGi0PuaV+6UDmG+2bVseG9sJ9zhEgfYvfNNz1lO0BqpQt/pGBrH4LLm9
        sbpZYpL+EkX1E82LpLGh/K3PPeVx9tQqpQdTCAI=
X-Google-Smtp-Source: APiQypK5xx0vKgwK+SdF17GGLs6t5Rula6yB+AUUFK0ASBnWAZ72i9usLf32veDPGMpnO5fctTfw4JHEoEikHOAhG+Q=
X-Received: by 2002:aca:f183:: with SMTP id p125mr12062503oih.74.1586158732351;
 Mon, 06 Apr 2020 00:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
In-Reply-To: <7221df0a-435b-f8bc-ff91-c188af535e73@gmail.com>
From:   Andrey Vagin <avagin@openvz.org>
Date:   Mon, 6 Apr 2020 00:38:38 -0700
Message-ID: <CANaxB-zAFux7ebEzJU5n8fzuTAtqUJ8NyBWU6WR1Do4nzFKCBg@mail.gmail.com>
Subject: Re: RFC: time_namespaces(7) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Dmitry Safonov <dima@arista.com>,
        linux-man <linux-man@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux API <linux-api@vger.kernel.org>,
        Containers <containers@lists.linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Reber <adrian@lisas.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Michael,

Thank you for writing this man page. I appreciate this. I will review
it on Mon or Tue.
