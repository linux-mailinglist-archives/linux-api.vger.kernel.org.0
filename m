Return-Path: <linux-api+bounces-1094-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D886F4F6
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 14:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 413D81C20BEC
	for <lists+linux-api@lfdr.de>; Sun,  3 Mar 2024 13:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FEC9470;
	Sun,  3 Mar 2024 13:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b="YVhA7+Zl";
	dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b="xSojZEhC"
X-Original-To: linux-api@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA75C121;
	Sun,  3 Mar 2024 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471385; cv=pass; b=NxvqN5i7GgGrYUh40+OgDA2Vez9om0WsCIw80M7VrGYBfRsI5ubkkfHvevBL81PmTGhBHVi/xglGsh5FETZsBAlHemjkw3ebHQ6u9GD7t+WUF2RlXWFwKjzAJAvTJnN9PwPBYSZQqcQ4LZ2Qb01RfFisPP0FM1tqIl7XHAdh6OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471385; c=relaxed/simple;
	bh=mUuX4mnpBDCRfLaR9qmjQNXq7OlnixAF6yCxynJ9AIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIaWkUW0SIZ7Ire/dqciD0UVu7K6cSRsoUfWtFZeUjFp6B89b7ZrtV5LquJh5T511G52ImZpm/26cZ8SA5ucXgFLLbl3jgopLg2c+39G0gQ3+oldp9MZoDmuTx+aLuW60upe6wW5SK9XSwyFjHUjiyVXiKPg6BfhDeSWZ458gkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org; spf=none smtp.mailfrom=clisp.org; dkim=pass (2048-bit key) header.d=clisp.org header.i=@clisp.org header.b=YVhA7+Zl; dkim=permerror (0-bit key) header.d=clisp.org header.i=@clisp.org header.b=xSojZEhC; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=clisp.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=clisp.org
ARC-Seal: i=1; a=rsa-sha256; t=1709469937; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=YmnGNB7uLpMucbC3fEQY5+7oEIpHQFokWgT9GmpjWt2+ZzaOBlMR75A6P0k7YDAF2v
    t7dtlHbfHg7mzs8sGn0bZ37PtxlzkMEyk9FYtzizq1hVt2pCTNsvMkvXmLtmid2cwDCB
    iopZ6XiFtNOPQtZ8znzWiYYxBDe2JFObQ8ofDtho0aLPb67Or7EmcdvCNXwSOCYjF3kk
    ThOi4OLEdnQ4gNjyvUYonjDApOFM/WnFPipWqPMPBmmCaw8UigZUlhZA9kUxNvms+8fd
    dHX092m/iKV1bCfdIHkCSJg55y7n0JuIBQ/ffLrhN4jsy78M+tVDm/llaB5XkpDQiGvN
    PYfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1709469937;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BWIRmxVb+ArmmWzye3GMWad9GL4jsYTpD+Amb8r4H98=;
    b=Blg2SI7H9gMYiT1r8pDJn//UNuDpomEmwhgWkmgEq0bxq1WI9D5NaopytULdDn5tNg
    RMA08cVTxIyXC6o74XiBHGqmFN8stFBG6ph0cfur8bxlI8ijAkQPx7M5tm9CZnNAnQln
    TGy/4CGiKMCBhP3y6sTmJmB9lP7/pGIkbdWCuikJfGdc8II/zaD1RmqzmZSOouG6UDnQ
    EY6vSX2dujeZAEqN3rejN/3yKYSoPSOfQ6g6jXii+N/FQDizqjJLSaj5hyL5FNasttYy
    BGp1RqbcXDxGTlyG2VsXXwxAE4MKDYKImqlRJQndNQ2OWjyb9PLopOwDYHCgA+enxaFE
    +SNA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1709469937;
    s=strato-dkim-0002; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BWIRmxVb+ArmmWzye3GMWad9GL4jsYTpD+Amb8r4H98=;
    b=YVhA7+ZlZhF2pNXYKd9H0BK/2akGR8N5AtnMGIFM3kLP3J8Fl+xsCBc3dToQg309CX
    bLUC0A2ZF6w3ifBnStYS8uoqaoqEk4YbJKfq4K6dOR14oG8YORzPvzEys8tlVqo5UIop
    wI4dElW2pYYXwEFi6hrcgVvgfmXHxol+spzQuaTG032c8gCYIiIhTdSlwDT8Vdsx0wLM
    l0czqYOvpUQQ9meCAxOTvsNLwffxc+ip+rtKrqNgmtkflnJ5272mTiZ+DIutuCkZJLNI
    EnbjaMyu1gZ8tYMbLwbPmojpJtLoYNolpVm95EIrBiAFvlups4ikwV3IqRdcnWMvGnos
    Hb3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1709469937;
    s=strato-dkim-0003; d=clisp.org;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=BWIRmxVb+ArmmWzye3GMWad9GL4jsYTpD+Amb8r4H98=;
    b=xSojZEhCv1Fi5wFngK1OuAQ+h3Wtp6xksL7RxjpRfkHrIGmSHcVuDYQiuDtFaVNfvK
    LtiFyRmF2t/Jfvt3+BAA==
X-RZG-AUTH: ":Ln4Re0+Ic/6oZXR1YgKryK8brlshOcZlIWs+iCP5vnk6shH0WWb0LN8XZoH94zq68+3cfpPH2qZYEItqMTA7sY+nxl9or98utQ=="
Received: from nimes.localnet
    by smtp.strato.de (RZmta 50.2.0 AUTH)
    with ESMTPSA id h61273023CjbWpq
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 3 Mar 2024 13:45:37 +0100 (CET)
From: Bruno Haible <bruno@clisp.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: Elliott Hughes <enh@google.com>, Stefan Puiu <stefan.puiu@gmail.com>, linux-man@vger.kernel.org, GNU C Library <libc-alpha@sourceware.org>, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] clock_nanosleep.2, nanosleep.2: Use 'duration' rather than 'request'
Date: Sun, 03 Mar 2024 13:45:37 +0100
Message-ID: <5882437.otsE0voPBg@nimes>
In-Reply-To: <20240303121454.16994-3-alx@kernel.org>
References: <ZUIlirG-ypudgpbK@debian> <20240303121454.16994-3-alx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Alejandro Colomar wrote:
>  man2/clock_nanosleep.2 | 20 ++++++++++----------
>  man2/nanosleep.2       | 12 ++++++------

The change to nanosleep.2 seems mostly fine. Except that the
term "requested relative duration" (line 142) raises questions;
what about changing that to "requested duration"?

The change to clock_nanosleep.2 seems wrong. There are two cases
(quoting the old text):

       If flags is 0, then the value specified in request is interpreted
       as an interval relative to the  current  value  of  the  clock
       specified by clockid.

       If  flags  is  TIMER_ABSTIME,  then request is interpreted as an
       absolute time as measured by the clock, clockid.  If request is
       less than or equal to the current value of the clock, then
       clock_nanosleep() returns immediately without suspending the  calling
       thread.

In the first case, the argument is a duration. In the second case, the
argument is an absolute time point; it would be wrong and very confusing
to denote it as "duration".

Bruno




