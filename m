Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE394DE60
	for <lists+linux-api@lfdr.de>; Fri, 21 Jun 2019 03:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfFUBTr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 20 Jun 2019 21:19:47 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:38590 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBTr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 20 Jun 2019 21:19:47 -0400
Received: by mail-pg1-f201.google.com with SMTP id 21so2980790pgl.5
        for <linux-api@vger.kernel.org>; Thu, 20 Jun 2019 18:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kxQz0Fl6z9VQMt6gH+UCTNHqWLDkknyKLbiNKZTb/0E=;
        b=uJA8GXH0tWNxWQqjFS6Ap0uI6ZKu38NASgDmqpItDDXYKTj8gwId0lUB1VZGgD41y/
         6m7/wysFDtuvXJARZSB6k7rXCMu51J69uqR/34U0Y/AunpvNNSzrHAvrsBnD3YDD9CVq
         TqlyBLSBPvuC8Zbo1sb8Aw6aB/iY6TOFYTNdJYGrAZ+En2qZdwu0mFB5aVCk91wS6NUQ
         qXrTq8SX8fyCgqibF9XK7XaIy5bXRHi+uzz2Y1dwI8/G26tKo2G5SRyyA/eyL5R6C2q1
         VRcEFw6OFqExjYqMoC/p5LcMtNwFl/waDeFjZL3jt88mwekmHM63N7hGCIsl0ORVSyP7
         ToAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kxQz0Fl6z9VQMt6gH+UCTNHqWLDkknyKLbiNKZTb/0E=;
        b=bdoqIRBDCYrLXAA/Sez3jRkeD11kDgxGj1hqnBJfDnarfBIyat35LHYKFC3Vekbfrz
         6aY3c180e/x2tXdDZEG/wnTYSeSEUZ3HHoZGRjcj7bsaBeU25JBqfdOHqP7cUcOYmxE3
         Eku6glPgm2vEec56gv2UIgVdfrkF33fQdsBaXxXsUxU+du17oibZAC+W/9PLYcN43U0M
         J5I93YmYbazID7JvnYp+yfl4Qgug97C4I4kvF1kMz3KP3PBuhs//UZyBKYLPXWZ8ZBtD
         eue/2gcfYM3g3mROOylVn/FOLeDJRp/IrP3xnWhHsb+DttsOeIZbNb6CzxgLrlG5VXhS
         RnrQ==
X-Gm-Message-State: APjAAAWHCvck04il16XcpN+6InubKiDC2IMYbv0ZtKfVf9EQwAjHuje+
        zNyP5UbPJHPqbg9jpreHp5822JZW64OBEyaO390JEA==
X-Google-Smtp-Source: APXvYqzCqvqrSBU1rWllCKWD+rrWgnjsFL1Z8JVckf99ZQFnKjoteOyh2Q0WrbeKLoF2vcQWiBqU02kbE3KzlWeGN+9lSw==
X-Received: by 2002:a63:4c1c:: with SMTP id z28mr15423435pga.122.1561079986483;
 Thu, 20 Jun 2019 18:19:46 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:19:11 -0700
Message-Id: <20190621011941.186255-1-matthewgarrett@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH V33 00/30] Lockdown as an LSM
From:   Matthew Garrett <matthewgarrett@google.com>
To:     jmorris@namei.org
Cc:     linux-security@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi James,

Let's see how this one goes. I've moved the lockdown code into an LSM
hook and provided an internal enum of lockdown reasons that LSMs can
either group or expose at whatever level of granularity is appropriate.
I've also included a static LSM that mimics the behaviour of the
existing patchset. I think there's a reasonable discussion to have about
what sort of granularity other LSMs might want to offer, but I don't
think that necessarily needs to be a blocker to merging this.

As with the last implementation, this can be enabled via static kernel
configuration, the kernel command line or via securityfs, depending on
usecase. Distributions may wish to tie it to UEFI Secure Boot state, but
we can save that conversation to later.

Thoughts?


